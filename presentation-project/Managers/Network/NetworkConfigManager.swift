//
//  NetworkConfigManager.swift
//  presentation-project
//
//  Created by Arturo Carretero Calvo on 20/3/23.
//  Copyright © 2023 ArtCC. All rights reserved.
//

import Foundation

// MARK: - Protocol

protocol NetworkConfigManager {
}

protocol SharedNetworkConfigManager {
  var cachePolicy: NSURLRequest.CachePolicy { get }
  var baseEndpoint: String { get }
}
