// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// MARK: - Strings

internal enum Localization {
  internal static let homeSearchError = Localization.translation("Localizable", "home.search.error")
  internal static let homeSearchPlaceholder = Localization.translation("Localizable", "home.search.placeholder")
  internal static let navigationWeatherTitle = Localization.translation("Localizable", "navigation.weather.title")
}

// MARK: - Implementation Details

extension Localization {
  private static func translation(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, arguments: args)
  }
}

private final class BundleToken {}
