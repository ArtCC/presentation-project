//
//  NetworkManager.swift
//  presentation-project
//
//  Created by Arturo Carretero Calvo on 20/3/23.
//  Copyright © 2023 ArtCC. All rights reserved.
//

import Alamofire
import Foundation

private struct Timeout {
  static let secondsForRequest = 30.0 // secs
  static let secondsForResource = 30.0 // secs
}

private struct StatusCode {
  static let valid = 200..<305 // acceptable status code range
}

open class NetworkManager {

  // MARK: - Properties

  let networkConfigManager: SharedNetworkConfigManager
  let reachabilityManager: NetworkReachabilityManager?
  let requestsDispatchQueue = DispatchQueue(label: "com.presentation.project.app.network.requests")

  var isReachable: Bool { reachabilityManager?.isReachable == true }

  private(set) var isDebugLoggingEnabled: Bool

  private var alamofireSession = Session()

  // MARK: - Init

  init(networkConfigManager: SharedNetworkConfigManager, enableDebugLogging: Bool) {
    self.networkConfigManager = networkConfigManager
    self.isDebugLoggingEnabled = enableDebugLogging

    // Set reachability manager
    reachabilityManager = NetworkReachabilityManager()

    // Session configuration
    let sessionConfig = URLSessionConfiguration.af.default
    sessionConfig.requestCachePolicy = networkConfigManager.cachePolicy
    sessionConfig.headers = .default
    sessionConfig.timeoutIntervalForRequest = Timeout.secondsForRequest
    sessionConfig.timeoutIntervalForResource = Timeout.secondsForResource
    sessionConfig.httpAdditionalHeaders = [:]

    let rootQueue = DispatchQueue(label: "org.alamofire.session.rootQueue")
    let delegateQueue = OperationQueue()
    delegateQueue.qualityOfService = .default
    delegateQueue.maxConcurrentOperationCount = 1
    delegateQueue.underlyingQueue = rootQueue
    delegateQueue.name = "org.alamofire.session.sessionDelegateQueue"
    delegateQueue.isSuspended = false

    let delegate = SessionDelegate()

    let urlSession = URLSession(configuration: sessionConfig, delegate: delegate, delegateQueue: delegateQueue)
    self.alamofireSession = Session(session: urlSession,
                                    delegate: delegate,
                                    rootQueue: rootQueue,
                                    interceptor: self)
  }

  // MARK: - Public

  func request<ErrorType: Decodable>(
    _ request: NetworkRequest,
    errorType: ErrorType.Type = EmptyDecodable.self,
    completion: @escaping (Swift.Result<NetworkResponse<Data>, NetworkError<ErrorType>>) -> Void) {
      requestsDispatchQueue.async {
        self.performRequestCheckingAuthentication(request, errorType: errorType, completion: completion)
      }
    }

  // MARK: - Helpers
  // Important: Do not call any of these helper methods from outside NetworkManager or its extensions

  /// Calls to this method must always be scheduled in `requestsDispatchQueue`.
  func performRequestCheckingAuthentication<ErrorType: Decodable>(
    _ request: NetworkRequest,
    errorType: ErrorType.Type = EmptyDecodable.self,
    completion: @escaping (Swift.Result<NetworkResponse<Data>, NetworkError<ErrorType>>) -> Void) {
      performRequest(request, errorType: errorType) { result in
        self.requestsDispatchQueue.async {
          DispatchQueue.main.async {
            completion(result)
          }
        }
      }
    }

  /// Calls to this method must always be scheduled in `requestsDispatchQueue`.
  func performRequest<ErrorType: Decodable>(
    _ request: NetworkRequest,
    errorType: ErrorType.Type = EmptyDecodable.self,
    completion: @escaping (Swift.Result<NetworkResponse<Data>, NetworkError<ErrorType>>) -> Void) {
      logRequest(request)
      if !isReachable {
        DispatchQueue.main.async {
          let networkErrorCode: NetworkErrorCode = .noConnection
          self.logNetworkErrorResponse(urlRequest: try? request.asURLRequest(), errorCode: networkErrorCode)
          completion(.failure(NetworkError(code: networkErrorCode, responseStatusCode: nil, response: nil)))
        }
      } else {
        let logResponse = createLogResponseClosure()
        let validatedDataRequest = alamofireSession.request(request)
          .validate(logResponse)
          .validate(statusCode: StatusCode.valid)
        validatedDataRequest.responseData { response in
          // Alamofire already dispatches this block on the main thread.
          self.handleResponse(response, completion: completion)
        }
      }
    }

  // MARK: - Private

  private func handleResponse<ErrorType: Decodable>(
    _ response: AFDataResponse<Data>,
    completion: @escaping (Swift.Result<NetworkResponse<Data>, NetworkError<ErrorType>>) -> Void) {
      let statusCode = response.response?.statusCode
      let headers = adaptHeaders(response.response?.allHeaderFields ?? [:])
      let data = response.data ?? Data()
      switch response.result {
      case .success:
        let networkResponse = NetworkResponse(statusCode: statusCode, headers: headers, data: data)
        completion(.success(networkResponse))
      case .failure:
        var errorCode: NetworkErrorCode = .generic
        var networkResponse: NetworkResponse<ErrorType>?
        if statusCode == NSURLErrorNotConnectedToInternet {
          errorCode = .noConnection
        } else if let errorModel = EntityParser().parse(data: data, entityType: ErrorType.self) {
          errorCode = NetworkErrorCode.from(code: statusCode)
          networkResponse = NetworkResponse(statusCode: statusCode, headers: headers, data: errorModel)
        } else {
          errorCode = NetworkErrorCode.from(code: statusCode)
        }
        let networkError = NetworkError(code: errorCode, responseStatusCode: statusCode, response: networkResponse)
        completion(.failure(networkError))
      }
    }

  private func adaptHeaders(_ headers: [AnyHashable: Any]) -> [String: String] {
    var adaptedHeaders: [String: String] = [:]
    for (key, value) in headers {
      guard let keyString = key as? String, let valueString = value as? String else {
        continue
      }
      adaptedHeaders[keyString] = valueString
    }
    return adaptedHeaders
  }
}
