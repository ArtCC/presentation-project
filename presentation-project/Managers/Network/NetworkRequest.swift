//
//  NetworkRequest.swift
//  presentation-project
//
//  Created by Arturo Carretero Calvo on 20/3/23.
//  Copyright © 2023 ArtCC. All rights reserved.
//

import Alamofire
import Foundation

enum HttpMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case patch = "PATCH"
  case delete = "DELETE"
  case head = "HEAD"
}

enum Encoding {
  case json
  case url

  func parameterEncoding() -> ParameterEncoding {
    switch self {
    case .json:
      return JSONEncoding.default
    case .url:
      return URLEncoding.default
    }
  }
}

struct NetworkRequest: URLRequestConvertible {

  let httpMethod: HttpMethod
  let encoding: ParameterEncoding
  let path: String
  let headers: [String: String]?
  let parameters: Parameters?

  init(httpMethod: HttpMethod,
       encoding: Encoding,
       path: String,
       headers: [String: String]? = nil,
       parameters: Parameters? = nil) {

    self.httpMethod = httpMethod
    self.encoding = encoding.parameterEncoding()
    self.path = path
    self.headers = headers
    self.parameters = parameters
  }

  func asURLRequest() throws -> URLRequest {
    guard let url = URL(string: path) else {
      throw NetworkErrorCode.unableToCreateUrl.toError()
    }
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = httpMethod.rawValue
    urlRequest.allHTTPHeaderFields = headers

    return try encoding.encode(urlRequest, with: parameters)
  }
}
