//
//  HomePresenter.swift
//  presentation-project
//
//  Created Arturo Carretero Calvo on 20/3/23.
//  Copyright © 2023 ArtCC. All rights reserved.
//

import Foundation

protocol HomePresentationLogic {
  func presentStaticData(response: Home.StaticData.Response)
  func presentSearch(response: Home.Search.Response)
}

class HomePresenter: HomePresentationLogic {

  // MARK: - Properties

  weak var viewController: HomeDisplayLogic?

  // MARK: - Public

  func presentStaticData(response: Home.StaticData.Response) {
    let viewModel = Home.StaticData.ViewModel()
    viewController?.displayStaticData(viewModel: viewModel)
  }

  func presentSearch(response: Home.Search.Response) {
    var action: HomeGetWeatherAction
    switch response.state {
    case .success(let entity):
      action = .success(data: createHomeViewData(with: entity))
    case .failure(let error):
      action = .failure(error: error)
    }
    let viewModel = Home.Search.ViewModel(action: action)
    viewController?.displaySearch(viewModel: viewModel)
  }

  // MARK: - Private

  private func createHomeViewData(with entity: WeatherEntity) -> HomeViewData {
    HomeViewData(identifier: entity.identifier, name: entity.name, temperature: "\(entity.temperature) ºC")
  }
}
