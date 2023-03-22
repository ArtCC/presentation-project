//
//  HomeModels.swift
//  presentation-project
//
//  Created Arturo Carretero Calvo on 20/3/23.
//  Copyright © 2023 ArtCC. All rights reserved.
//

import Foundation

// MARK: - Use cases

enum Home {
  enum StaticData {
    struct Request {
    }

    struct Response {
    }

    struct ViewModel {
    }
  }

  enum Text {
    struct Request {
      let text: String?
    }
  }

  enum Search {
    struct Request {
    }

    struct Response {
      let state: HomeGetWeatherState
    }

    struct ViewModel {
      let action: HomeGetWeatherAction
    }
  }
}

// MARK: - Business models

enum HomeGetWeatherState {
  case success(entity: WeatherEntity)
  case failure(error: String)
}

// MARK: - View models

enum HomeGetWeatherAction {
  case success(data: HomeViewData)
  case failure(error: String)
}

struct HomeViewData {
  let identifier: Int
  let name: String
  let temperature: String
}
