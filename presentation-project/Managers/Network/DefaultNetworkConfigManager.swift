//
//  DefaultNetworkConfigManager.swift
//  presentation-project
//
//  Created by Arturo Carretero Calvo on 20/3/23.
//  Copyright © 2023 ArtCC. All rights reserved.
//

import Foundation

class DefaultNetworkConfigManager: NetworkConfigManager, SharedNetworkConfigManager {

  // MARK: - Properties

  var cachePolicy: NSURLRequest.CachePolicy {
    .reloadIgnoringLocalAndRemoteCacheData
  }

  var baseEndpoint: String {
    "https://api.openweathermap.org"
  }

  // MARK: - Lifecycle

  init() {
  }
}
