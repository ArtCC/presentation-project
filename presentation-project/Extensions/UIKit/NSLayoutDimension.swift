//
//  NSLayoutDimension.swift
//  presentation-project
//
//  Created by Arturo Carretero Calvo on 20/3/23.
//  Copyright © 2023 ArtCC. All rights reserved.
//

import UIKit

extension NSLayoutDimension {

  @objc func constraint(equalToConstant constant: CGFloat, priority: UILayoutPriority) -> NSLayoutConstraint {
    let newConstraint = constraint(equalToConstant: constant)
    newConstraint.priority = priority
    return newConstraint
  }

  @objc func constraint(greaterThanOrEqualToConstant constant: CGFloat,
                        priority: UILayoutPriority) -> NSLayoutConstraint {
    let newConstraint = constraint(greaterThanOrEqualToConstant: constant)
    newConstraint.priority = priority
    return newConstraint
  }

  @objc func constraint(lessThanOrEqualToConstant constant: CGFloat, priority: UILayoutPriority) -> NSLayoutConstraint {
    let newConstraint = constraint(lessThanOrEqualToConstant: constant)
    newConstraint.priority = priority
    return newConstraint
  }
}
