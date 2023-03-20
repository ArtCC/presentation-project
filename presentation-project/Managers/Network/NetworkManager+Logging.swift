//
//  NetworkManager+Logging.swift
//  presentation-project
//
//  Created by Arturo Carretero Calvo on 20/3/23.
//  Copyright © 2023 ArtCC. All rights reserved.
//

import Alamofire
import Foundation

extension NetworkManager {

  func logRequest(_ request: NetworkRequest) {
    guard isDebugLoggingEnabled,
          let urlRequest = try? request.asURLRequest(),
          let urlString = urlRequest.url?.absoluteString else {
      return
    }
    logRequest(httpMethod: request.httpMethod,
               urlString: urlString,
               parameters: request.parameters,
               httpBody: urlRequest.httpBody,
               headers: urlRequest.allHTTPHeaderFields)
  }

  func logRequest(httpMethod: HttpMethod,
                  urlString: URLConvertible,
                  parameters: [String: Any]?,
                  httpBody: Data? = nil,
                  headers: [String: String]?) {
    guard isDebugLoggingEnabled else {
      return
    }
    var logs = ["\(httpMethod.rawValue.uppercased()) \(urlString)"]
    if let headers = headers, !headers.isEmpty {
      if let jsonData = try? JSONSerialization.data(withJSONObject: headers, options: .prettyPrinted),
         let jsonStr = String(data: jsonData, encoding: .utf8) {
        logs += ["headers:"]
        logs += jsonStr.components(separatedBy: "\n")
      }
    }
    if let parameters = parameters, !parameters.isEmpty {
      if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted),
         let jsonStr = String(data: jsonData, encoding: .utf8) {
        logs += ["params:"]
        logs += jsonStr.components(separatedBy: "\n")
      }
    }
    if let body = httpBody {
      if let jsonStr = String(data: body, encoding: .utf8) {
        logs += ["body:"]
        logs += jsonStr.components(separatedBy: "\n")
      }
    }
    printLog("NetworkManager:request: \( "\n".join(logs))")
  }

  func logNetworkErrorResponse(urlRequest: URLRequest?, errorCode: NetworkErrorCode) {
    guard isDebugLoggingEnabled else {
      return
    }
    let requestString = getSimpleRequestString(urlRequest: urlRequest)
    let errorCodeString = "errorCode: \(errorCode.rawValue)"
    printLog("NetworkManager:response: \(requestString) --> \(errorCodeString)")
  }

  func getSimpleRequestString(urlRequest: URLRequest?) -> String {
    guard let urlRequest = urlRequest else {
      return ""
    }
    let httpMethod = urlRequest.httpMethod?.uppercased() ?? ""
    let requestUrl = urlRequest.url?.absoluteString ?? ""
    return "\(httpMethod) \(requestUrl)"
  }

  func createLogResponseClosure() -> DataRequest.Validation {
    let closure: DataRequest.Validation = { [weak self] request, response, data in
      if let self = self, self.isDebugLoggingEnabled {
        let title = "NetworkManager:response:"
        let requestString = self.getSimpleRequestString(urlRequest: request)
        let statusCode = response.statusCode
        let statusCodeString = "statusCode: \(statusCode)"
        printLog("\(title) \(requestString) --> \(statusCodeString), utf8Data: \(String(describing: data))")
      }
      return .success(())
    }
    return closure
  }
}
