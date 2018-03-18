//
//  ConverterViewAssembly.swift
//  CurrencyConverter
//
//  Created by Антон Назаров on 15/03/2018.
//  Copyright © 2018 Electrolux. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

class ConverterViewAssembly: Assembly {
  func assemble(container: Container) {
    container.register(ConverterViewController.self) {
      let controller = ConverterViewController(nibName: nil, bundle: nil)
      controller.presenter = $0 ~> ConverterPresenter.self
      return controller
    }
  }
}
