//
//  Network+Weather.swift
//  presentation-project
//
//  Created by Arturo Carretero Calvo on 20/3/23.
//  Copyright © 2023 ArtCC. All rights reserved.
//

import Foundation

private enum WeatherAPIEndpoint {
  static let getWeather = "/data/2.5/weather"
}

protocol WeatherAPI {
  func getWeather(parameters: GetWeatherParameters,
                  completion: @escaping(Result<WeatherEntity, GetWeatherError>) -> Void)
}

extension NetworkManager: WeatherAPI {

  func getWeather(parameters: GetWeatherParameters,
                  completion: @escaping(Result<WeatherEntity, GetWeatherError>) -> Void) {
    let requestData = GetWeatherRequestData(parameters: parameters)

    var urlComponents = URLComponents(string: networkConfigManager.baseEndpoint)
    urlComponents?.path = WeatherAPIEndpoint.getWeather

    let path = urlComponents?.url?.absoluteString ?? ""
    let networkRequest = NetworkRequest(httpMethod: .get,
                                        encoding: .url,
                                        path: path,
                                        headers: requestData.getHeaders(),
                                        parameters: requestData.getParameters())

    request(networkRequest) { networkResult in
      switch networkResult {
      case .success(let response):
        printLog("weather: \(response)")

        let parser = EntityParser()

        if let entity = parser.parse(data: response.data,
                                     entityType: GetWeatherResponse.self,
                                     statusCode: response.statusCode,
                                     headers: response.headers) {
          completion(.success(entity))
        } else {
          completion(.failure(.responseProblems))
        }
      case .failure(let error):
        switch error.code {
        case .noConnection:
          completion(.failure(.noConnection))
        default:
          completion(.failure(.responseProblems))
        }
      }
    }
  }
}
