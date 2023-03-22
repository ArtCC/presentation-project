//
//  HomeInteractor.swift
//  presentation-project
//
//  Created Arturo Carretero Calvo on 20/3/23.
//  Copyright © 2023 ArtCC. All rights reserved.
//

import Foundation

protocol HomeBusinessLogic {
  func doLoadStaticData(request: Home.StaticData.Request)
  func doLoadText(request: Home.Text.Request)
  func doLoadSearch(request: Home.Search.Request)
}

protocol HomeDataStore {
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {

  // MARK: - Properties

  var presenter: HomePresentationLogic?
  var weatherManager: WeatherAPI?

  private var text: String?

  // MARK: - Public

  func doLoadStaticData(request: Home.StaticData.Request) {
    let response = Home.StaticData.Response()
    presenter?.presentStaticData(response: response)
  }

  func doLoadText(request: Home.Text.Request) {
    text = request.text
  }

  func doLoadSearch(request: Home.Search.Request) {
    guard let text else {
      let response = Home.Search.Response(state: .failure(error: Localization.homeSearchError))
      presenter?.presentSearch(response: response)
      return
    }
    weatherManager?.getWeather(parameters: GetWeatherParameters(search: text), completion: { result in

      var state: HomeGetWeatherState
      switch result {
      case .success(let entity):
        printLog("Entity: \(entity)")

        state = .success(entity: entity)
      case .failure(let failure):
        printLog("Error: \(failure.localizedDescription)")

        state = .failure(error: Localization.homeSearchError)
      }

      let response = Home.Search.Response(state: state)
      self.presenter?.presentSearch(response: response)
    })
  }
}
