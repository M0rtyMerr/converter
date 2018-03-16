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
    let element = XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element
    XCTAssertTrue(element.children(matching: .textField).element(boundBy: 0).exists)
    XCTAssertTrue(element.children(matching: .textField).element(boundBy: 1).exists)
    XCTAssertTrue(element.children(matching: .textField).element(boundBy: 2).exists)
    XCTAssertTrue(element.children(matching: .textField).element(boundBy: 3).exists)
  }
  
  func testPickerAppear() {
    let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element
    element.children(matching: .textField).element(boundBy: 1).tap()
    XCTAssertTrue(app.pickers["picker"].exists)
  }
}
