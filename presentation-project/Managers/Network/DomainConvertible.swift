//
//  DomainConvertible.swift
//  presentation-project
//
//  Created by Arturo Carretero Calvo on 20/3/23.
//  Copyright © 2023 ArtCC. All rights reserved.
//

import Foundation

protocol DomainConvertible {
  associatedtype DomainEntityType
  func domainEntity(statusCode: Int?, headers: [String: String]) -> DomainEntityType?
}
