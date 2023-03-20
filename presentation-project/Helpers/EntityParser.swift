//
//  EntityParser.swift
//  presentation-project
//
//  Created by Arturo Carretero Calvo on 20/3/23.
//  Copyright © 2023 ArtCC. All rights reserved.
//

import Foundation

struct EntityParser {

  init() {
  }

  func parse<MyDecodable: Decodable>(data: Data, entityType: MyDecodable.Type) -> MyDecodable? {
    let decoder = JSONDecoder()
    var returnValue: MyDecodable?
    do {
      let data = (data.isEmpty) ? try JSONSerialization.data(withJSONObject: [:]) : data
      returnValue = try decoder.decode(entityType, from: data)
    } catch {
      if let derror = error as? DecodingError {
        printLog("**********************************************************")
        printLog(derror.localizedDescription)
        printLog("\(derror)")
        printLog("**********************************************************")
      }
    }
    return returnValue
  }

  func parse<MyDecodable: Decodable & DomainConvertible>(
    data: Data,
    entityType: MyDecodable.Type,
    statusCode: Int?,
    headers: [String: String]
  ) -> MyDecodable.DomainEntityType? {
    let entity = parse(data: data, entityType: entityType)
    return entity?.domainEntity(statusCode: statusCode, headers: headers)
  }

  func parse<MyDecodable: Decodable & DomainConvertible>(
    data: Data,
    entityType: [MyDecodable].Type,
    statusCode: Int?,
    headers: [String: String]
  ) -> [MyDecodable.DomainEntityType]? {
    let entities = parse(data: data, entityType: entityType)
    return entities?.compactMap { $0.domainEntity(statusCode: statusCode, headers: headers) }
  }
}
