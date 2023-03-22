//
//  Weather+Response.swift
//  presentation-project
//
//  Created by Arturo Carretero Calvo on 22/3/23.
//  Copyright © 2023 ArtCC. All rights reserved.
//

import Foundation

// MARK: - Response

struct GetWeatherResponse: Decodable, DomainConvertible {

  // MARK: - Entity

  typealias DomainEntityType = WeatherEntity

  // MARK: - Properties

  enum CodingKeys: String, CodingKey {
    case identifier = "id"
    case name
    case main
  }

  private let identifier: Int
  private let name: String
  private let main: MainResponse?

  // MARK: - Init

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    identifier = try values.decodeIfPresent(Int.self, forKey: .identifier) ?? 0
    name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
    main = try values.decodeIfPresent(MainResponse.self, forKey: .main)
  }

  func domainEntity(statusCode: Int?, headers: [String: String]) -> WeatherEntity? {
    WeatherEntity(identifier: identifier, name: name, temperature: main?.temp ?? 0.0)
  }

  // MARK: - Private

  private struct MainResponse: Decodable {

    enum CodingKeys: String, CodingKey {
      case temp
    }

    let temp: Double

    init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      temp = try values.decodeIfPresent(Double.self, forKey: .temp) ?? 0.0
    }
  }
}
