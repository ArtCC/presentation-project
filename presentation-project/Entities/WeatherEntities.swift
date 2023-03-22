//
//  WeatherEntities.swift
//  presentation-project
//
//  Created by Arturo Carretero Calvo on 22/3/23.
//  Copyright © 2023 ArtCC. All rights reserved.
//

import Foundation

// MARK: - Entities

struct WeatherEntity {
  let identifier: Int
  let name: String
  let temperature: Double
}

// MARK: - Parameters

struct GetWeatherParameters {
  let search: String
}

// MARK: - Errors

enum GetWeatherError: Error {
  case responseProblems
  case noConnection
}
