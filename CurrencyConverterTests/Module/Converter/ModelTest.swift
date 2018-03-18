//
//  ModelTest.swift
//  CurrencyConverterTests
//
//  Created by Anton Nazarov1 on 3/16/18.
//  Copyright © 2018 Electrolux. All rights reserved.
//

import Quick
import Nimble
@testable import CurrencyConverter

class ModelTest: QuickSpec {
  override func spec() {
    describe("Model test") {
      it("maps symbols dto") {
        let symbols = try! JSONDecoder().decode(SymbolsDto.self, from: Util.getJSON(name: Util.Res.symbols.rawValue))
        expect(symbols.success) == true
        expect(symbols.symbols.count) == 2
        expect(symbols.symbols["AED"]) == "United Arab Emirates Dirham"
      }
      
      it("maps convert dto") {
        let convert = try! JSONDecoder().decode(ConvertDto.self, from: Util.getJSON(name: Util.Res.convert.rawValue))
        expect(convert.success) == true
        expect(convert.result) == 3724.305775
      }
    }
  }
}

