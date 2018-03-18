//
//  CurrencyConverterUITests.swift
//  CurrencyConverterUITests
//
//  Created by Anton Nazarov1 on 3/15/18.
//  Copyright © 2018 Electrolux. All rights reserved.
//

import XCTest

class CurrencyConverterUITests: XCTestCase {
  var app: XCUIApplication!

  override func setUp() {
    super.setUp()
    continueAfterFailure = false
    app = XCUIApplication()
    app.launch()
  }

  override func tearDown() {
    super.tearDown()
  }

  func testDefaultUI() {
    XCTAssertTrue(app.textFields[ElementKey.fromAmount.rawValue].exists)
    XCTAssertTrue(app.textFields[ElementKey.toAmount.rawValue].exists)
    XCTAssertTrue(app.textFields[ElementKey.toCurrency.rawValue].exists)
    XCTAssertTrue(app.textFields[ElementKey.fromCurrency.rawValue].exists)
  }

  func testPickerAppear() {
    app.textFields[ElementKey.toCurrency.rawValue].tap()
    XCTAssertTrue(app.pickers[ElementKey.picker.rawValue].exists)
  }

  func testPickerDisappear() {
    app.textFields[ElementKey.toCurrency.rawValue].tap()
    app.otherElements.containing(.textField, identifier: ElementKey.toCurrency.rawValue).element.tap()
    XCTAssertFalse(app.pickers[ElementKey.picker.rawValue].exists)
  }

  func testAmountChangeAfterFromCurrencyChange() {
    let amount = getAmount()
    app.textFields[ElementKey.fromCurrency.rawValue].tap()
    app.pickers[ElementKey.picker.rawValue].swipeUp()
    sleep(1)
    XCTAssertNotEqual(amount, getAmount())
  }

  func testAmountChangeAfterToCurrencyChange() {
    let amount = getAmount()
    app.textFields[ElementKey.toCurrency.rawValue].tap()
    app.pickers[ElementKey.picker.rawValue].swipeUp()
    sleep(1)
    XCTAssertNotEqual(amount, getAmount())
  }

  func testAmountChangeAfterFromAmountChange() {
    let amount = getAmount()
    app.textFields[ElementKey.fromAmount.rawValue].tap()
    app.textFields[ElementKey.fromAmount.rawValue].typeText("1")
    XCTAssertNotEqual(amount, getAmount())
  }

  func testPopoverAfterInvalidFormat() {
    app.textFields[ElementKey.fromAmount.rawValue].tap()
    app.textFields[ElementKey.fromAmount.rawValue].typeText("not_valid")
    XCTAssertTrue(app.alerts[ElementKey.alert.rawValue].exists)
  }

  private func getAmount() -> String {
    guard let amount = app.textFields[ElementKey.toAmount.rawValue].value as? String else {
      fatalError("Unexpected state")
    }
    return amount
  }
}
