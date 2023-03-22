//
//  HomeInteractorTests.swift
//  presentation-project
//
//  Created by Arturo Carretero Calvo on 20/3/23.
//  Copyright © 2023 ArtCC. All rights reserved.
//

import XCTest

@testable import presentation_project

class HomeInteractorTests: XCTestCase {

  // MARK: - Subject under test

  var interactor: HomeInteractor?
  var presenterSpy: HomePresentationLogicSpy?
  var weatherApiSpy: WeatherApiSpy?

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    setupHomeInteractor()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Test setup

  func setupHomeInteractor() {
    interactor = HomeInteractor()
    presenterSpy = HomePresentationLogicSpy()
    weatherApiSpy = WeatherApiSpy()

    interactor?.weatherApi = weatherApiSpy
    interactor?.presenter = presenterSpy
  }

  // MARK: - Test doubles

  class HomePresentationLogicSpy: HomePresentationLogic {

    var presentStaticDataCalled = false
    var presentSearchCalled = false

    var presentStaticDataResponse: Home.StaticData.Response?
    var presentSearchResponse: Home.Search.Response?

    func presentStaticData(response: Home.StaticData.Response) {
      presentStaticDataCalled = true
      presentStaticDataResponse = response
    }

    func presentSearch(response: Home.Search.Response) {
      presentSearchCalled = true
      presentSearchResponse = response
    }
  }

  // MARK: - Tests

  func testDoLoadSearchWithSuccess() {
    // Given
    let weatherEntity = WeatherEntity(identifier: 1, name: "Madrid", temperature: 13)
    weatherApiSpy?.getWeatherResult = .success(weatherEntity)
    let request = Home.Search.Request()

    // When
    interactor?.doLoadSearch(request: request)

    // Then
    XCTAssertEqual(weatherApiSpy?.getWeatherCalled, true, "doLoadSearch() should aks weatherApi to getWeather")
    XCTAssertEqual(presenterSpy?.presentSearchCalled, true,
                   "doLoadSearch() should ask the presenter to presentSearch()")
  }

  func testDoLoadSearchWithNoConnection() {
    // Given
    weatherApiSpy?.getWeatherResult = .failure(.noConnection)
    let request = Home.Search.Request()

    // When
    interactor?.doLoadSearch(request: request)

    // Then
    XCTAssertEqual(weatherApiSpy?.getWeatherCalled, true, "doLoadSearch() should aks weatherApi to getWeather")
    XCTAssertEqual(presenterSpy?.presentSearchCalled, true,
                   "doLoadSearch() should ask the presenter to presentSearch()")
  }

  func testDoLoadSearchWithResponseProblems() {
    // Given
    weatherApiSpy?.getWeatherResult = .failure(.responseProblems)
    let request = Home.Search.Request()

    // When
    interactor?.doLoadSearch(request: request)

    // Then
    XCTAssertEqual(weatherApiSpy?.getWeatherCalled, true, "doLoadSearch() should aks weatherApi to getWeather")
    XCTAssertEqual(presenterSpy?.presentSearchCalled, true,
                   "doLoadSearch() should ask the presenter to presentSearch()")
  }
}
