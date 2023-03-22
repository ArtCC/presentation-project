//
//  UIColor.swift
//  presentation-project
//
//  Created by Arturo Carretero Calvo on 22/3/23.
//  Copyright © 2023 ArtCC. All rights reserved.
//

import UIKit

extension UIColor {

  convenience init(hex: String) {
    var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if cString.hasPrefix("#") {
      cString.remove(at: cString.startIndex)
    }

    if cString.count == 3 {
      cString = cString.map({ "\($0)\($0)" }).joined()
    }

    if !cString.isValidUsingRegex(Regex.hexNumber) || cString.count != 6 { // without alpha
      self.init(red: 255, green: 255, blue: 255, alpha: 1.0) // white
    } else {
      var rgbValue: UInt64 = 0
      Scanner(string: cString).scanHexInt64(&rgbValue)
      let red = CGFloat((rgbValue & 0xFF0000) >> 16)
      let green = CGFloat((rgbValue & 0x00FF00) >> 8)
      let blue = CGFloat(rgbValue & 0x0000FF)
      self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1.0)
    }
  }

  static func create(named name: String) -> UIColor {
    UIColor(named: name) ?? .black
  }

  func hexString() -> String {
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0

    getRed(&red, green: &green, blue: &blue, alpha: &alpha)

    let rgb: Int = Int(red * 255) << 16 | Int(green * 255) << 8 | Int(blue * 255) << 0
    return String(format: "#%06x", rgb)
  }
}
