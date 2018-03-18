//
//  CurrencyConverterTests.swift
//  CurrencyConverterTests
//
//  Created by Anton Nazarov1 on 3/15/18.
//  Copyright © 2018 Electrolux. All rights reserved.
//

import Quick
import Nimble
@testable import CurrencyConverter

class FixerTest: QuickSpec {
  override func spec() {
    describe("Url format test") {
      it("returns correct path to symbols") {
        expect(Fixer.Endpoint.symbols.build()).to(beginWith("\(Util.base)symbols\(Util.accessKey)"))
      }

      it("returns correct path to latest") {
        expect(Fixer.Endpoint.latest.build()).to(beginWith("\(Util.base)latest\(Util.accessKey)"))
      }

      it("returns correct path to convert") {
        let from = IU.someString(), to = IU.someString(), amount = IU.someDouble()
        let urlString = Fixer.Endpoint.convert(from: from, to: to, amount: amount).build()
        expect(urlString).to(beginWith("\(Util.base)convert\(Util.accessKey)"))
        expect(urlString).to(endWith("&from=\(from)&to=\(to)&amount=\(amount)"))
      }
    }
  }
}
