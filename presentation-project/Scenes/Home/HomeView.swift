//
//  HomeView.swift
//  presentation-project
//
//  Created Arturo Carretero Calvo on 20/3/23.
//  Copyright © 2023 ArtCC. All rights reserved.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
  func homeViewDidChangeTextSearch(_ view: HomeView, text: String?)
  func homeViewDidTapSearch(_ view: HomeView)
}

class HomeView: UIView {

  // MARK: - Constants

  private struct ViewTraits {
    // Margin
    static let stackViewSpacing: CGFloat = 10

    // Font
    static let fontSize: CGFloat = 24
  }

  // MARK: - Properties

  private let searchBar = UISearchBar()
  private let stackView = UIStackView()
  private let titleLabel = UILabel()
  private let tempLabel = UILabel()
  private let errorLabel = UILabel()

  weak var delegate: HomeViewDelegate?

  // MARK: - Lifecycle

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupComponents()
    setupConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Public

  func setupUI(data: HomeViewData) {
    titleLabel.text = data.name
    tempLabel.text = data.temperature

    titleLabel.isHidden = false
    tempLabel.isHidden = false
    errorLabel.isHidden = true
  }

  func setError(_ error: String) {
    errorLabel.text = error

    titleLabel.isHidden = true
    tempLabel.isHidden = true
    errorLabel.isHidden = false
  }

  // MARK: - Private

  private func setupComponents() {
    backgroundColor = .white

    searchBar.placeholder = Localization.homeSearchPlaceholder
    searchBar.keyboardType = .namePhonePad
    searchBar.returnKeyType = .search
    searchBar.delegate = self

    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = ViewTraits.stackViewSpacing

    titleLabel.font = UIFont(name: Constants.fontName, size: ViewTraits.fontSize)
    titleLabel.textAlignment = .center

    tempLabel.font = UIFont(name: Constants.fontName, size: ViewTraits.fontSize)
    tempLabel.textAlignment = .center

    errorLabel.font = UIFont(name: Constants.fontName, size: ViewTraits.fontSize)
    errorLabel.textAlignment = .center
    errorLabel.numberOfLines = 0

    stackView.addArrangedSubview(titleLabel)
    stackView.addArrangedSubview(tempLabel)
    stackView.addArrangedSubview(errorLabel)

    addSubviewForAutolayout(searchBar)
    addSubviewForAutolayout(stackView)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),

      stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
      stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }

  private func viewDataReset() {
    titleLabel.text = nil
    tempLabel.text = nil
    errorLabel.text = nil

    titleLabel.isHidden = true
    tempLabel.isHidden = true
    errorLabel.isHidden = true

    searchBar.text = nil
  }
}

// MARK: - UISearchBarDelegate

extension HomeView: UISearchBarDelegate {

  func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
    viewDataReset()

    return true
  }

  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    delegate?.homeViewDidChangeTextSearch(self, text: searchText)
  }

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()

    delegate?.homeViewDidTapSearch(self)
  }
}
