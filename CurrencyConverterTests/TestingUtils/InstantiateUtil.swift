//
//  InstantiateUtil.swift
//  CurrencyConverterTests
//
//  Created by Anton Nazarov1 on 3/16/18.
//  Copyright © 2018 Electrolux. All rights reserved.
//

import Fakery

enum InstantiateUtil {
  private static let faker = Faker(locale: "nb-NO")

  static func someString() -> String {
    return faker.internet.ipV6Address()
  }

  static func someDouble() -> Double {
    return faker.number.randomDouble()
  }

  static func someCurrency() -> String {
  return "United Arab Emirates Dirham"
  }
}

//swiftlint:disable:next type_name
typealias IU = InstantiateUtil
