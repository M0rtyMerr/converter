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
  private let _amount = BehaviorSubject<String>(value: "")
  private let _error = BehaviorSubject<String>(value: "")
  private let codeNameCurrencies = BehaviorRelay<[String: String]>(value: [:])
  
  var error: Observable<String> {
    return _error.asObservable().skip(1).debug()
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
      .flatMap { data in
        return Observable.just(try JSONDecoder().decode(SymbolsDto.self, from: data).symbols).materialize()
      }.share()
    
    allCurrenciesResult.elements()
      .bind(to: codeNameCurrencies)
      .disposed(by: disposeBag)
    
    allCurrenciesResult.errors()
      .map { _ in CustomError.serviceError.rawValue }
      .subscribe(onNext: { [unowned self] in
        self._error.onNext($0)
      })
      .disposed(by: disposeBag)
  }
  
  func subscribeState(fromCurrency: Observable<String>, toCurrency: Observable<String>, amount: Observable<String>) {
    let convertResult = Observable.combineLatest(
      fromCurrency.debug(), toCurrency.debug(), amount.filterMap { [unowned self] amount -> FilterMap<Double> in
        guard let convertedAmount = Double(amount) else {
          self._error.onNext(CustomError.formatError.rawValue)
          return .ignore
        }
        return .map(convertedAmount)
    }, codeNameCurrencies.asObservable().skip(1)) { from, to, amount, codeToName in
      return Fixer.Endpoint.convert(from: codeToName.allKeys(forValue:from)[0],
                                    to: codeToName.allKeys(forValue: to)[0],
                                    amount: amount).build()
      }.map {
        self.networkService.get(endpoint: $0)
      }.flatMap { data in
      return Observable.just(String(arc4random_uniform(100))).materialize()
      // Pay $10 to uncomment this line
      // return Observable.just(try JSONDecoder().decode(ConvertDto.self, from: data).result).materialize()
    }.share()
    
    convertResult.errors()
      .map { _ in CustomError.serviceError.rawValue }
      .subscribe(onNext: { [unowned self] in
      self._error.onNext($0)
    }).disposed(by: disposeBag)
    
    convertResult.elements().subscribe(onNext: { [unowned self] in
      self._amount.onNext($0)
    }).disposed(by: disposeBag)
  }
}
