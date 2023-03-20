//
//  SplashInteractor.swift
//  presentation-project
//
//  Created Arturo Carretero Calvo on 20/3/23.
//  Copyright © 2023 ArtCC. All rights reserved.
//

import Foundation

protocol SplashBusinessLogic {
  func doLoadStaticData(request: Splash.StaticData.Request)
  func doLoadData(request: Splash.Data.Request)
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

  func doLoadData(request: Splash.Data.Request) {
    /**
     The splash scene directs navigation to a login, a home, a jailbreak scene, maintenance, etc.
     In this case it is simulated.
     */
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
      let response = Splash.Data.Response()
      self.presenter?.presentData(response: response)
    }
  }
}
