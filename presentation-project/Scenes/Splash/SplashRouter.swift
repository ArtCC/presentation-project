//
//  SplashRouter.swift
//  presentation-project
//
//  Created Arturo Carretero Calvo on 20/3/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SplashRoutingLogic {
  func routeBack()
}

protocol SplashDataPassing {
  var dataStore: SplashDataStore? { get }
}

class SplashRouter: SplashRoutingLogic, SplashDataPassing {

  // MARK: - Properties

  weak var viewController: SplashViewController?
  
  var dataStore: SplashDataStore?

  // MARK: - Routing

  func routeBack() {
    viewController?.navigationController?.popViewController(animated: true)
  }
}
