//
//  PPNetworkManager.swift
//  presentation-project
//
//  Created by Arturo Carretero Calvo on 20/3/23.
//  Copyright © 2023 ArtCC. All rights reserved.
//

import Foundation

class PPNetworkManager: NetworkManager {

  // MARK: - Properties

  let ppNetworkConfigManager: NetworkConfigManager

  // MARK: - Init

  init(networkConfigManager: NetworkConfigManager,
       sharedNetworkConfigManager: SharedNetworkConfigManager,
       enableDebugLogging: Bool) {
    self.ppNetworkConfigManager = networkConfigManager
    super.init(networkConfigManager: sharedNetworkConfigManager, enableDebugLogging: enableDebugLogging)
  }
}
