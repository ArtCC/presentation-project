//
//  HomeViewController.swift
//  presentation-project
//
//  Created Arturo Carretero Calvo on 20/3/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
  func displayStaticData(viewModel: Home.StaticData.ViewModel)
}

class HomeViewController: UIViewController {

  // MARK: - Properties

  var interactor: HomeBusinessLogic?
  var router: (HomeRoutingLogic & HomeDataPassing)?

  private let sceneView = HomeView()

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
    let interactor = HomeInteractor()
    let presenter = HomePresenter()
    let router = HomeRouter()
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
    setupNavigationBar()
    doLoadStaticData()
  }

  // MARK: - Private

  private func setupNavigationBar() {
  }
}

// MARK: - Output

extension HomeViewController {

  private func doLoadStaticData() {
    let request = Home.StaticData.Request()
    interactor?.doLoadStaticData(request: request)
  }
}

// MARK: - Input

extension HomeViewController: HomeDisplayLogic {

  func displayStaticData(viewModel: Home.StaticData.ViewModel) {
  }
}
