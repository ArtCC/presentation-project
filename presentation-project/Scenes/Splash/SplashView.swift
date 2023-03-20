//
//  SplashView.swift
//  presentation-project
//
//  Created Arturo Carretero Calvo on 20/3/23.
//  Copyright © 2023 ArtCC. All rights reserved.
//

import UIKit

class SplashView: UIView {

  // MARK: - Constants

  private struct ViewTraits {
    // Margin
    static let indicatorViewTop: CGFloat = 10

    // Size
    static let splashImageViewSize: CGFloat = 250
  }

  // MARK: - Properties

  private let splashImageView = UIImageView()
  private let indicatorView = UIActivityIndicatorView()

  // MARK: - Lifecycle

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupComponents()
    setupConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Private

  private func setupComponents() {
    backgroundColor = .white

    splashImageView.contentMode = .scaleAspectFit
    splashImageView.image = UIImage(named: "img_splash")

    indicatorView.style = .large
    indicatorView.startAnimating()

    addSubviewForAutolayout(splashImageView)
    addSubviewForAutolayout(indicatorView)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      splashImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
      splashImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
      splashImageView.heightAnchor.constraint(equalToConstant: ViewTraits.splashImageViewSize),
      splashImageView.widthAnchor.constraint(equalToConstant: ViewTraits.splashImageViewSize),

      indicatorView.topAnchor.constraint(equalTo: splashImageView.bottomAnchor, constant: ViewTraits.indicatorViewTop),
      indicatorView.centerXAnchor.constraint(equalTo: splashImageView.centerXAnchor)
    ])
  }
}
