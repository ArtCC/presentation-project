//
//  HomeRouter.swift
//  presentation-project
//
//  Created Arturo Carretero Calvo on 20/3/23.
//  Copyright © 2023 ArtCC. All rights reserved.
//

import UIKit

protocol HomeRoutingLogic {
}

protocol HomeDataPassing {
  var dataStore: HomeDataStore? { get }
}

class HomeRouter: HomeRoutingLogic, HomeDataPassing {

  // MARK: - Properties

  weak var viewController: HomeViewController?

  var dataStore: HomeDataStore?
}
