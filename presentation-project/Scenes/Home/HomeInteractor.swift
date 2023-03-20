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
}

protocol HomeDataStore {
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {

  // MARK: - Properties

  var presenter: HomePresentationLogic?

  // MARK: - Public

  func doLoadStaticData(request: Home.StaticData.Request) {
    let response = Home.StaticData.Response()
    presenter?.presentStaticData(response: response)
  }

  // MARK: - Private
}
