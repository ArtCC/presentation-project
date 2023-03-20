//
//  SplashInteractor.swift
//  presentation-project
//
//  Created Arturo Carretero Calvo on 20/3/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol SplashBusinessLogic {
  func doLoadStaticData(request: Splash.StaticData.Request)
}

protocol SplashDataStore {
}

class SplashInteractor: SplashBusinessLogic, SplashDataStore {

  // MARK: - Properties

  var presenter: SplashPresentationLogic?

  // MARK: - Public

  func doLoadStaticData(request: Splash.StaticData.Request) {
    let response = Splash.StaticData.Response()
    presenter?.presentStaticData(response: response)
  }

  // MARK: - Private
}
