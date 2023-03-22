//
//  HomePresenterTests.swift
//  presentation-project
//
//  Created by Arturo Carretero Calvo on 20/3/23.
//  Copyright © 2023 ArtCC. All rights reserved.
//

import XCTest

@testable import presentation_project

final class HomePresenterTests: XCTestCase {

  // MARK: - Subject under test

  var presenter: HomePresenter?
  var viewControllerSpy: HomeDisplayLogicSpy?

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    setupHomePresenter()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Test setup

  func setupHomePresenter() {
    presenter = HomePresenter()
    viewControllerSpy = HomeDisplayLogicSpy()
    presenter?.viewController = viewControllerSpy
  }

  // MARK: - Test doubles

  class HomeDisplayLogicSpy: HomeDisplayLogic {

    var displayStaticDataCalled = false
    var displayStaticDataViewModel: Home.StaticData.ViewModel?
    var displaySearchCalled = false
    var displaySearchViewModel: Home.Search.ViewModel?

    func displayStaticData(viewModel: Home.StaticData.ViewModel) {
      displayStaticDataCalled = true
      displayStaticDataViewModel = viewModel
    }

    func displaySearch(viewModel: Home.Search.ViewModel) {
      displaySearchCalled = true
      displaySearchViewModel = viewModel
    }
  }

  // MARK: - Tests

  func testPresentSearchSuccess() {
    // Given
    let weatherEntity = WeatherEntity(identifier: 1, name: "Madrid", temperature: 13)
    let response = Home.Search.Response(state: .success(entity: weatherEntity))

    // When
    presenter?.presentSearch(response: response)

    // Then
    XCTAssertEqual(viewControllerSpy?.displaySearchCalled, true,
                   "presentData() should ask the view controller to displaySearch()")
  }

  func testPresentSearchFailure() {
    // Given
    let error = HomeGetWeatherState.failure(error: "An error has occurred, please try again after a few minutes")
    let response = Home.Search.Response(state: error)

    // When
    presenter?.presentSearch(response: response)

    // Then
    XCTAssertEqual(viewControllerSpy?.displaySearchCalled, true,
                   "presentData() should ask the view controller to displaySearch()")
  }
}
