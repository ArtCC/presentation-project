//
//  SplashPresenter.swift
//  presentation-project
//
//  Created Arturo Carretero Calvo on 20/3/23.
//  Copyright © 2023 ArtCC. All rights reserved.
//

import Foundation

protocol SplashPresentationLogic {
  func presentStaticData(response: Splash.StaticData.Response)
  func presentData(response: Splash.Data.Response)
}

class SplashPresenter: SplashPresentationLogic {

  // MARK: - Properties

  weak var viewController: SplashDisplayLogic?

  // MARK: - Public

  func presentStaticData(response: Splash.StaticData.Response) {
    let viewModel = Splash.StaticData.ViewModel()
    viewController?.displayStaticData(viewModel: viewModel)
  }

  func presentData(response: Splash.Data.Response) {
    let viewModel = Splash.Data.ViewModel()
    viewController?.displayData(viewModel: viewModel)
  }
}
