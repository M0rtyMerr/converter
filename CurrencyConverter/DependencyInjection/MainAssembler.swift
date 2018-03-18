//
//  MainAssembler.swift
//  CurrencyConverter
//
//  Created by Антон Назаров on 15/03/2018.
//  Copyright © 2018 Electrolux. All rights reserved.
//

import Swinject

class MainAssembler {
  static func getAssemblies() -> [Assembly] {
    return [
      // Service
      ServiceAssembly(),
      // Converter
      ConverterViewAssembly(),
      ConverterPresenterAssembly()
    ]
  }
}
