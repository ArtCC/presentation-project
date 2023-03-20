//
//  NetworkManager+RequestInterceptor.swift
//  presentation-project
//
//  Created by Arturo Carretero Calvo on 20/3/23.
//  Copyright © 2023 ArtCC. All rights reserved.
//

import Alamofire
import Foundation

extension NetworkManager: RequestInterceptor {

  // MARK: - Adapter

  public func adapt(_ urlRequest: URLRequest,
                    for session: Session,
                    completion: @escaping (Result<URLRequest, Error>) -> Void) {
    requestsDispatchQueue.async {
      completion(.success(urlRequest))
    }
  }

  // MARK: - Retrier

  public func retry(_ request: Request,
                    for session: Session,
                    dueTo error: Error,
                    completion: @escaping (RetryResult) -> Void) {
    requestsDispatchQueue.async {
      completion(.doNotRetry)
    }
  }
}
