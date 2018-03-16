//
//  ConverterPresenterAssembly.swift
//  CurrencyConverter
//
//  Created by Антон Назаров on 16/03/2018.
//  Copyright © 2018 Electrolux. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

class ConverterPresenterAssembly: Assembly {
  func assemble(container: Container) {
    container.autoregister(ConverterPresenter.self, initializer: ConverterPresenterImpl.init)
  }
}
