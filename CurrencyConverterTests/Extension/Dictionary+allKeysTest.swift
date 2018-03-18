//
//  Dictionary+allKeysTest.swift
//  CurrencyConverterTests
//
//  Created by Антон Назаров on 18/03/2018.
//  Copyright © 2018 Electrolux. All rights reserved.
//

import Quick
import Nimble
@testable import CurrencyConverter

class DictionaryAllKeysTest: QuickSpec {
  override func spec() {
    describe("allKeys test") {
      it("returns all keys by value") {
        expect([1: 1, 2: 1].allKeys(forValue: 1)) == [2, 1]
      }
    }
  }
}
