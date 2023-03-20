//
//  PrintLog.swift
//  presentation-project
//
//  Created by Arturo Carretero Calvo on 20/3/23.
//  Copyright © 2023 ArtCC. All rights reserved.
//

import Foundation

/// Print log only in debug.
/// - Parameter data: log information data.
func printLog<T>(_ data: T?) {
#if DEBUG
  if let data = data {
    print(data)
  }
#endif
}
