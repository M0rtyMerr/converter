//
//  NetworkService.swift
//  CurrencyConverter
//
//  Created by Антон Назаров on 15/03/2018.
//  Copyright © 2018 Electrolux. All rights reserved.
//

import Foundation
import RxSwift

protocol NetworkService {
  func get(endpoint: String) -> Observable<Any>
}
