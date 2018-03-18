//
//  ConverterPresenterImpl.swift
//  CurrencyConverter
//
//  Created by Антон Назаров on 15/03/2018.§
//  Copyright © 2018 Electrolux. All rights reserved.
//

import RxSwift
import RxCocoa
import RxSwiftExt

class ConverterPresenterImpl: ConverterPresenter {
  private let disposeBag = DisposeBag()
  private let networkService: NetworkService
  private let _amount = ReplaySubject<String>.create(bufferSize: 1)
  private let _error = ReplaySubject<Error>.create(bufferSize: 1)
  private let codeNameCurrencies = ReplaySubject<[String: String]>.create(bufferSize: 1)

  var error: Observable<String> {
    return _error.map { $0.localizedDescription }.asObservable()
  }
  var currencies: Observable<[String]> {
    return codeNameCurrencies.asObservable().map { Array($0.values) }
  }
  var amount: Observable<String> {
    return _amount.asObservable()
  }

  init(networkService: NetworkService) {
    self.networkService = networkService
    let allCurrenciesResult = networkService.get(endpoint: Fixer.Endpoint.symbols.build())
      .flatMap { data -> Observable<Event<[String: String]>> in
        do {
          let symbols = try JSONDecoder().decode(SymbolsDto.self, from: data).symbols
          return Observable.just(symbols).materialize()
        } catch {
          return Observable.error(CustomError.serviceError).materialize()
        }
      }.share()

    allCurrenciesResult.elements().bind(to: codeNameCurrencies).disposed(by: disposeBag)
    allCurrenciesResult.errors().subscribe(onNext: {
      log.error("All currency request error:\($0)")
      self._error.onNext($0)
    }).disposed(by: disposeBag)
  }

  func subscribeState(fromCurrency: Observable<String>, toCurrency: Observable<String>, amount: Observable<String>) {
    let convertResult = Observable.combineLatest(
      fromCurrency, toCurrency, amount.filterMap { [unowned self] amount -> FilterMap<Double> in
      guard let convertedAmount = Double(amount) else {
        self._error.onNext(CustomError.formatError)
        return .ignore
      }
      return .map(convertedAmount)
      }, codeNameCurrencies.asObservable()) { from, to, amount, codeToName in
        Fixer.Endpoint.convert(from: codeToName.allKeys(forValue: from)[0],
                               to: codeToName.allKeys(forValue: to)[0],
                               amount: amount).build()
    }.flatMap {
      self.networkService.get(endpoint: $0)
    }.flatMap { _ in
      Observable.just(String(arc4random_uniform(100))).materialize()
//    Pay $10 to uncomment this line
//    Observable.just(String(try JSONDecoder().decode(ConvertDto.self, from: $0).result)).materialize()
    }.share()

    convertResult.elements().bind(to: _amount).disposed(by: disposeBag)
    convertResult.errors().subscribe(onNext: {
      log.error("Convert request error:\($0)")
      self._error.onNext($0)
    }).disposed(by: disposeBag)
  }
}
