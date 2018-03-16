//
//  ServiceAssembly.swift
//  CurrencyConverter
//
//  Created by Антон Назаров on 15/03/2018.
//  Copyright © 2018 Electrolux. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

class ServiceAssembly: Assembly {
  func assemble(container: Container) {
    container.autoregister(NetworkService.self, initializer: NetworkServiceImpl.init)
  }
}
