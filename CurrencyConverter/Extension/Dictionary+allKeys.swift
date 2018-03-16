//
//  Dictionary+allKeys.swift
//  CurrencyConverter
//
//  Created by Anton Nazarov1 on 3/16/18.
//  Copyright © 2018 Electrolux. All rights reserved.
//

extension Dictionary where Value: Equatable {
  func allKeys(forValue val: Value) -> [Key] {
    return self.filter { $1 == val }.map { $0.0 }
  }
}
