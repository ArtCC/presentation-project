//
//  HomeViewController.swift
//  presentation-project
//
//  Created Arturo Carretero Calvo on 20/3/23.
//  Copyright © 2023 ArtCC. All rights reserved.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
  func displayStaticData(viewModel: Home.StaticData.ViewModel)
  func displaySearch(viewModel: Home.Search.ViewModel)
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
    interactor.weatherApi = Managers.network
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }

  // MARK: - View's lifecycle

  override func loadView() {
    view = sceneView

    sceneView.delegate = self
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
    doLoadStaticData()
  }

  // MARK: - Private

  private func setupNavigationBar() {
    title = Localization.navigationWeatherTitle

    navigationController?.navigationBar.backgroundColor = .neutralWhite
  }
}

// MARK: - Output

extension HomeViewController {

  private func doLoadStaticData() {
    let request = Home.StaticData.Request()
    interactor?.doLoadStaticData(request: request)
  }

  private func doLoadText(for text: String?) {
    let request = Home.Text.Request(text: text)
    interactor?.doLoadText(request: request)
  }

  private func doLoadSearch() {
    let request = Home.Search.Request()
    interactor?.doLoadSearch(request: request)
  }
}

// MARK: - Input

extension HomeViewController: HomeDisplayLogic {

  func displayStaticData(viewModel: Home.StaticData.ViewModel) {
  }

  func displaySearch(viewModel: Home.Search.ViewModel) {
    switch viewModel.action {
    case .success(let data):
      sceneView.setupUI(data: data)
    case .failure(let error):
      sceneView.setError(error)
    }
  }
}

// MARK: - HomeViewDelegate

extension HomeViewController: HomeViewDelegate {

  func homeViewDidChangeTextSearch(_ view: HomeView, text: String?) {
    doLoadText(for: text)
  }

  func homeViewDidTapSearch(_ view: HomeView) {
    doLoadSearch()
  }
}
