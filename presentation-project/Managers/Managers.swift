//
//  Managers.swift
//  presentation-project
//
//  Created by Arturo Carretero Calvo on 20/3/23.
//  Copyright © 2023 ArtCC. All rights reserved.
//

import Foundation

class Managers {

  static let networkConfig = DefaultNetworkConfigManager()
  static let network = PPNetworkManager(networkConfigManager: networkConfig,
                                        sharedNetworkConfigManager: networkConfig,
                                        enableDebugLogging: true)

  // MARK: - Public

  static func setup() {
  }
}
