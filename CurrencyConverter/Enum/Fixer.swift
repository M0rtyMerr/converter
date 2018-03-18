//
//  Fixer.swift
//  CurrencyConverter
//
//  Created by Антон Назаров on 15/03/2018.
//  Copyright © 2018 Electrolux. All rights reserved.
//

enum Fixer {
  private static let base = "http://data.fixer.io/api/"
  private static let apiKey: String = {
    guard let key = SettingsService.getFromSettings(key: SettingsKey.apiKey) as? String else {
      fatalError("No valid api key")
    }
    return "?access_key=" + key
  }()

  enum Endpoint {
    case symbols
    case latest
    case convert(from: String, to: String, amount: Double)

    func build() -> String {
      return base + path()
    }

    private func path() -> String {
      switch self {
      case .symbols:
        return "symbols" + apiKey
      case .latest:
        return "latest" + apiKey
      case .convert(let from, let to, let amount):
        return "convert" + apiKey + "&from=\(from)&to=\(to)&amount=\(amount)"
      }
    }
  }
}
