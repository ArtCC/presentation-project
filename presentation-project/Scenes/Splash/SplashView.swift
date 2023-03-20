//
//  SplashView.swift
//  presentation-project
//
//  Created Arturo Carretero Calvo on 20/3/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class SplashView: UIView {

  // MARK: - Constants

  private struct ViewTraits {
  }

  // MARK: - Properties

  // MARK: - Lifecycle

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupComponents()
    setupConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Actions

  // MARK: - Public

  func setupUI(data: SplashViewData) {
  }

  // MARK: - Private

  private func setupComponents() {
    backgroundColor = .red
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
    ])
  }
}
