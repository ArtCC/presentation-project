//
//  SplashPresenter.swift
//  presentation-project
//
//  Created Arturo Carretero Calvo on 20/3/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol SplashPresentationLogic {
  func presentStaticData(response: Splash.StaticData.Response)
}

class SplashPresenter: SplashPresentationLogic {

  // MARK: - Properties

  weak var viewController: SplashDisplayLogic?

  // MARK: - Public

  func presentStaticData(response: Splash.StaticData.Response) {
    let viewModel = Splash.StaticData.ViewModel()
    viewController?.displayStaticData(viewModel: viewModel)
  }
  
  // MARK: - Private
}
