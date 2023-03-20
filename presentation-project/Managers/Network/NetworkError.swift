//
//  NetworkError.swift
//  presentation-project
//
//  Created by Arturo Carretero Calvo on 20/3/23.
//  Copyright © 2023 ArtCC. All rights reserved.
//

import Foundation

// MARK: - Enum

// https://httpstatuses.com/
enum NetworkErrorCode: Int {
  case accessTokenExpired = -5
  case noConnection = -4
  case unableToParseResponse = -3
  case unableToCreateUrl = -2
  case generic = -1
  case notModified = 304
  case badRequest = 400
  case unauthorized = 401
  case forbidden = 403
  case notFound = 404
  case methodNotAllowed = 405
  case requestTimeout = 408
  case conflict = 409
  case gone = 410
  case preconditionFailed = 412
  case unprocessableEntity = 422
  case upgradeRequired = 426
  case tooManyRequests = 429
  case unavailableForLegalReasons = 451
  case internalServerError = 500
  case badGateway = 502
  case serviceUnavailable = 503
  case gatewayTimeout = 504

  static func from(code: Int?) -> NetworkErrorCode {
    if let code = code, let error = NetworkErrorCode(rawValue: code) {
      return error
    }
    return .generic
  }

  static func from(error: Error) -> NetworkErrorCode {
    NetworkErrorCode(rawValue: (error as NSError).code) ?? .generic
  }

  func toError(withDomain domain: String = ErrorDomain.network) -> Error {
    NSError(domain: domain, code: rawValue, userInfo: nil)
  }
}

enum CustomErrorCode: String {
  case generic
}

// MARK: Struct

struct ErrorDomain {
  static let network = "com.presentation.project.network.error"
}

struct NetworkError<T: Decodable>: Error {
  let code: NetworkErrorCode
  let responseStatusCode: Int?
  let response: NetworkResponse<T>?
}

struct ServerCustomErrorResponse: Decodable {
  let errors: [ServerCustomError]
}

struct ServerCustomError: Decodable {
  enum CodingKeys: String, CodingKey {
    case code
    case message
  }

  let code: String
  let message: String

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    code = try values.decodeIfPresent(String.self, forKey: .code) ?? ""
    message = try values.decodeIfPresent(String.self, forKey: .message) ?? ""
  }
}

struct EmptyDecodable: Decodable {
}
