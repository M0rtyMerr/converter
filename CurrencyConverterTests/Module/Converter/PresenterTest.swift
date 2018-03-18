//
//  PresenterTest.swift
//  CurrencyConverterTests
//
//  Created by Anton Nazarov1 on 3/16/18.
//  Copyright © 2018 Electrolux. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RxBlocking
import RxNimble
@testable import CurrencyConverter

class PresenterTest: QuickSpec {
  override func spec() {
    describe("Presenter test") {
      context("Mocked network service, state not subscribe") {
        let mock = NetworkServiceMock()

        it("return currency list before subscribing on state") {
          let presenter = ConverterPresenterImpl(networkService: mock)
          expect(presenter.currencies).first == ["Afghan Afghani", "United Arab Emirates Dirham"]
        }

        it("fire error if network request returns unexpected data") {
          mock.withError = true
          let presenter = ConverterPresenterImpl(networkService: mock)
          expect(presenter.error).first == CustomError.serviceError.localizedDescription
        }
      }

      context("Mocked network service, state subscribed") {
        let mock = NetworkServiceMock()
        it("fire amount") {
          let presenter = ConverterPresenterImpl(networkService: mock)
          presenter.subscribeState(fromCurrency: Observable.just(IU.someCurrency()),
                                   toCurrency: Observable.just(IU.someCurrency()),
                                   amount: Observable.just(String(IU.someDouble())))

          expect(presenter.currencies).first == ["Afghan Afghani", "United Arab Emirates Dirham"]
          //Can't test random gen
//          expect(presenter.amount).last == String(3_724.305_775)
        }

        it("fire format error with incorrect input") {
          let presenter = ConverterPresenterImpl(networkService: mock)
          presenter.subscribeState(fromCurrency: Observable.just(IU.someCurrency()),
                                   toCurrency: Observable.just(IU.someCurrency()),
                                   amount: Observable.just(String(IU.someString())))
          expect(presenter.error).first == CustomError.formatError.localizedDescription
        }

        it("fire service error") {
          mock.withError = true
          let presenter = ConverterPresenterImpl(networkService: mock)
          presenter.subscribeState(fromCurrency: Observable.just(IU.someCurrency()),
                                   toCurrency: Observable.just(IU.someCurrency()),
                                   amount: Observable.just(String(IU.someDouble())))
          expect(presenter.error).first == CustomError.serviceError.localizedDescription

        }
      }
    }
  }
}
