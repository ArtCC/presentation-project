//
//  WeatherApiSpy.swift
//  presentation-projectTests
//
//  Created by Arturo Carretero Calvo on 22/3/23.
//  Copyright © 2023 ArtCC. All rights reserved.
//

import Foundation

@testable import presentation_project

class WeatherApiSpy: WeatherAPI {

  // MARK: - Properties

  var getWeatherResult: Result<WeatherEntity, GetWeatherError> = .failure(.noConnection)

  // MARK: - Spy properties

  var getWeatherCalled = false

  // MARK: - Public

  func getWeather(parameters: presentation_project.GetWeatherParameters,
                  completion: @escaping (Result<WeatherEntity, GetWeatherError>) -> Void) {
    getWeatherCalled = true

    completion(getWeatherResult)
  }
}
