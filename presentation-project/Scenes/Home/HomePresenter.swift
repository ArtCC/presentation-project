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
}

class HomePresenter: HomePresentationLogic {

  // MARK: - Properties

  weak var viewController: HomeDisplayLogic?

  // MARK: - Public

  func presentStaticData(response: Home.StaticData.Response) {
    let viewModel = Home.StaticData.ViewModel()
    viewController?.displayStaticData(viewModel: viewModel)
  }

  // MARK: - Private
}
