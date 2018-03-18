//
//  NetworkServiceMock.swift
//  CurrencyConverterTests
//
//  Created by Anton Nazarov1 on 3/16/18.
//  Copyright © 2018 Electrolux. All rights reserved.
//

import RxSwift
@testable import CurrencyConverter

class NetworkServiceMock: NetworkService {
  init() {
  }
  
  var withError = false
  
  func get(endpoint: String) -> Observable<Data> {
    if withError {
      return Observable.just(Data())
    }
    
    if endpoint.starts(with: "\(Util.base)symbols") {
      return Observable.just(Util.getJSON(name: Util.Res.symbols.rawValue))
    } else if endpoint.starts(with: "\(Util.base)convert") {
      return Observable.just(Util.getJSON(name: Util.Res.convert.rawValue))
    }
    
    fatalError("Not excpected endpoint")
  }
}
