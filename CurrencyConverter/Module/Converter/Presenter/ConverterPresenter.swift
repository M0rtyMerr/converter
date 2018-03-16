//
//  ConverterPresenter.swift
//  CurrencyConverter
//
//  Created by Антон Назаров on 15/03/2018.
//  Copyright © 2018 Electrolux. All rights reserved.
//

import RxSwift

protocol ConverterPresenter {
  var currencies: Observable<[String]> { get }
  var toAmount: Observable<String> { get }
  var fromAmount: Observable<String> { get }
  var error: Observable<String> { get }

  func dispatch(action: ConverterAction)
}
