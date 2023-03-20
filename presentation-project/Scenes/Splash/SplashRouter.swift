//
//  SplashRouter.swift
//  presentation-project
//
//  Created Arturo Carretero Calvo on 20/3/23.
//  Copyright © 2023 ArtCC. All rights reserved.
//

import UIKit

protocol SplashRoutingLogic {
  func routeToHome()
}

protocol SplashDataPassing {
  var dataStore: SplashDataStore? { get }
}

class SplashRouter: SplashRoutingLogic, SplashDataPassing {

  // MARK: - Properties

  weak var viewController: SplashViewController?

  var dataStore: SplashDataStore?

  // MARK: - Routing

  func routeToHome() {
    let destinationVC = HomeViewController()
    let destinationNC = UINavigationController(rootViewController: destinationVC)

    if let sceneDelegate = UIApplication.shared.openSessions.first?.scene?.delegate as? SceneDelegate,
       let window = sceneDelegate.window {
      presentNewRoot(viewController: destinationNC, window: window, scaling: true)
    }
  }

  // MARK: - Private

  private func presentNewRoot(viewController: UIViewController, window: UIWindow, scaling: Bool) {
    if let snapshot = window.snapshotView(afterScreenUpdates: true) {
      viewController.view.addSubview(snapshot)
      window.rootViewController = viewController
      UIView.animate(withDuration: 0.3, animations: {
        snapshot.layer.opacity = Float(0.0)
        if scaling {
          snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
        }
      }, completion: { _ in
        snapshot.removeFromSuperview()
      })
    }
  }
}
