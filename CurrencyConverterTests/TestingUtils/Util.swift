//
//  Util.swift
//  CurrencyConverterTests
//
//  Created by Anton Nazarov1 on 3/16/18.
//  Copyright © 2018 Electrolux. All rights reserved.
//

import Foundation

class Util {
  static let base = "http://data.fixer.io/api/"
  static let accessKey = "?access_key="

  enum Res: String {
    case symbols
    case convert
  }

  static func getJSON(name: String) -> Data {
    guard let path = Bundle(for: Util.self).path(forResource: name, ofType: "json") else {
      fatalError("Error while reading \(name)")
    }
    //swiftlint:disable:next force_try
    return try! NSData(contentsOfFile: path) as Data
  }
}
