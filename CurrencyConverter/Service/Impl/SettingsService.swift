//
//  SettingsService.swift
//  CurrencyConverter
//
//  Created by Антон Назаров on 15/03/2018.
//  Copyright © 2018 Electrolux. All rights reserved.
//

import Foundation

class SettingsService {
  private static var settings = getSettings()

  static func getFromSettings(key: String) -> AnyObject? {
    return settings[key]
  }

  static private func getSettings() -> [String: AnyObject] {
    guard let path = Bundle.main.path(forResource: SettingsKeys.filename, ofType: SettingsKeys.ofType),
      let settings = NSDictionary(contentsOfFile: path) as? [String: AnyObject]
      else {
        fatalError("Couldn't load application settings")
    }
    return settings
  }
}
