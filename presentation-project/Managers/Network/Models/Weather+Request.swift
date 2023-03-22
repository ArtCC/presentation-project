//
//  Weather+Request.swift
//  presentation-project
//
//  Created by Arturo Carretero Calvo on 22/3/23.
//  Copyright © 2023 ArtCC. All rights reserved.
//

import Foundation

// MARK: - Request

struct GetWeatherRequestData {

  // MARK: - Properties

  private var parameters: GetWeatherParameters

  // MARK: - Init

  init(parameters: GetWeatherParameters) {
    self.parameters = parameters
  }

  // MARK: - Public

  func getHeaders() -> [String: String] {
    [
      "Accept": "application/json"
    ]
  }

  func getParameters() -> [String: Any] {
    [
      "q": parameters.search ?? "",
      "appid": Constants.openWeatherApiKey,
      "lang": "es",
      "units": "metric"
    ]
  }
}
