//
//  ConverterPresenterImpl.swift
//  CurrencyConverter
//
//  Created by Антон Назаров on 15/03/2018.
//  Copyright © 2018 Electrolux. All rights reserved.
//

import RxSwift
import RxCocoa
import RxSwiftExt

class ConverterPresenterImpl: ConverterPresenter {
  private let _error = ReplaySubject<Error>.create(bufferSize: 1)
  private let disposeBag = DisposeBag()
  private let networkService: NetworkService
  private let _toAmount = BehaviorSubject<String>(value: "")
  private let _fromAmount = BehaviorSubject<String>(value: "")
  private let codeNameCurrencies = BehaviorRelay<[String: String]>(value: [:])
  
  var error: Observable<String> {
    return _error.asObservable().map { $0.localizedDescription }
  }
  var currencies: Observable<[String]> {
    return codeNameCurrencies.asObservable().map { Array($0.values) }
  }
  var toAmount: Observable<String> {
    return _toAmount.asObservable()
  }
  var fromAmount: Observable<String> {
    return _fromAmount.asObservable()
  }
  
  
  init(networkService: NetworkService) {
    self.networkService = networkService
    let allCurrenciesResult = networkService.get(endpoint: Fixer.Endpoint.symbols.build())
      .map { data -> [String: String] in
        do {
          return try JSONDecoder().decode(SymbolsDto.self, from: data).symbols
        } catch {
          throw CustomError.serviceError
        }
      }
      .share()
      .materialize()
    
    allCurrenciesResult.elements()
      .bind(to: codeNameCurrencies)
      .disposed(by: disposeBag)
    
    allCurrenciesResult.errors()
      .bind(to: _error)
      .disposed(by: disposeBag)
  }
  
  func dispatch(action: ConverterAction) {
    switch action {
    case .changeState(let from, let to, let amount, let changedBy):
      guard let amount = Double(amount) else {
        _error.onNext(CustomError.formatError)
        return
      }
      
      let convertResult = networkService.get(endpoint: Fixer.Endpoint.convert(from: from, to: to, amount: amount).build())
        .map { data -> String in
          do {
            return try JSONDecoder().decode(ConvertDto.self, from: data).result
          } catch {
            throw CustomError.serviceError
          }
        }
        .share()
        .materialize()
      
      convertResult.errors().bind(to: _error).disposed(by: disposeBag)
      convertResult.elements().subscribe(onNext: {
        switch changedBy{
        case .from:
          self._fromAmount.onNext($0)
        case .to:
          self._toAmount.onNext($0)
        }
      }).disposed(by: disposeBag)
    }
  }
}
