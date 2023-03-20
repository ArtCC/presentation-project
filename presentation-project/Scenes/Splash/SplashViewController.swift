//
//  SplashViewController.swift
//  presentation-project
//
//  Created Arturo Carretero Calvo on 20/3/23.
//  Copyright © 2023 ArtCC. All rights reserved.
//

import UIKit

protocol SplashDisplayLogic: AnyObject {
  func displayStaticData(viewModel: Splash.StaticData.ViewModel)
  func displayData(viewModel: Splash.Data.ViewModel)
}

class SplashViewController: UIViewController {

  // MARK: - Properties

  var interactor: SplashBusinessLogic?
  var router: (SplashRoutingLogic & SplashDataPassing)?

  private let sceneView = SplashView()

  // MARK: - Object's lifecycle

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  // MARK: - Setup

  private func setup() {
    let viewController = self
    let interactor = SplashInteractor()
    let presenter = SplashPresenter()
    let router = SplashRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }

  // MARK: - View's lifecycle

  override func loadView() {
    view = sceneView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    doLoadStaticData()
  }
}

// MARK: - Output

extension SplashViewController {

  private func doLoadStaticData() {
    let request = Splash.StaticData.Request()
    interactor?.doLoadStaticData(request: request)
  }

  private func doLoadData() {
    let request = Splash.Data.Request()
    interactor?.doLoadData(request: request)
  }
}

// MARK: - Input

extension SplashViewController: SplashDisplayLogic {

  func displayStaticData(viewModel: Splash.StaticData.ViewModel) {
    doLoadData()
  }

  func displayData(viewModel: Splash.Data.ViewModel) {
    router?.routeToHome()
  }
}
