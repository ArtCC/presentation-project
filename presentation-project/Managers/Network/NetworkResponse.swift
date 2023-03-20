//
//  NetworkResponse.swift
//  presentation-project
//
//  Created by Arturo Carretero Calvo on 20/3/23.
//  Copyright © 2023 ArtCC. All rights reserved.
//

import Foundation

struct NetworkResponse<T> {
  let statusCode: Int?
  let headers: [String: String]
  let data: T
}
