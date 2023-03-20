//
//  String.swift
//  presentation-project
//
//  Created by Arturo Carretero Calvo on 20/3/23.
//  Copyright © 2023 ArtCC. All rights reserved.
//

import Foundation

extension String {

  func join<S: Sequence>(_ elements: S) -> String {
    elements.map { String(describing: $0) }.joined(separator: self)
  }
}
