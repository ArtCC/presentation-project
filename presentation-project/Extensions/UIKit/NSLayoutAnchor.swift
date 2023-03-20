//
//  NSLayoutAnchor.swift
//  presentation-project
//
//  Created by Arturo Carretero Calvo on 20/3/23.
//  Copyright © 2023 ArtCC. All rights reserved.
//

import UIKit

extension NSLayoutAnchor {

  @objc func constraint(equalTo anchor: NSLayoutAnchor<AnchorType>, priority: UILayoutPriority) -> NSLayoutConstraint {
    constraint(equalTo: anchor, constant: 0, priority: priority)
  }

  @objc func constraint(greaterThanOrEqualTo anchor: NSLayoutAnchor<AnchorType>,
                        priority: UILayoutPriority) -> NSLayoutConstraint {
    constraint(greaterThanOrEqualTo: anchor, constant: 0, priority: priority)
  }

  @objc func constraint(lessThanOrEqualTo anchor: NSLayoutAnchor<AnchorType>,
                        priority: UILayoutPriority) -> NSLayoutConstraint {
    constraint(lessThanOrEqualTo: anchor, constant: 0, priority: priority)
  }

  @objc func constraint(equalTo anchor: NSLayoutAnchor<AnchorType>,
                        constant: CGFloat,
                        priority: UILayoutPriority) -> NSLayoutConstraint {
    let newConstraint = constraint(equalTo: anchor, constant: constant)
    newConstraint.priority = priority
    return newConstraint
  }

  @objc func constraint(greaterThanOrEqualTo anchor: NSLayoutAnchor<AnchorType>,
                        constant: CGFloat,
                        priority: UILayoutPriority) -> NSLayoutConstraint {
    let newConstraint = constraint(greaterThanOrEqualTo: anchor, constant: constant)
    newConstraint.priority = priority
    return newConstraint
  }

  @objc func constraint(lessThanOrEqualTo anchor: NSLayoutAnchor<AnchorType>,
                        constant: CGFloat,
                        priority: UILayoutPriority) -> NSLayoutConstraint {
    let newConstraint = constraint(lessThanOrEqualTo: anchor, constant: constant)
    newConstraint.priority = priority
    return newConstraint
  }
}
