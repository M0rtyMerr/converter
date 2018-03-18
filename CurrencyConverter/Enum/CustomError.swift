//
//  CustomError.swift
//  CurrencyConverter
//
//  Created by Антон Назаров on 15/03/2018.
//  Copyright © 2018 Electrolux. All rights reserved.
//

import Foundation

enum CustomError: Error {
  case serviceError
  case formatError
}

extension CustomError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .serviceError:
      return NSLocalizedString("Service error", comment: "Custom error")
    case .formatError:
      return NSLocalizedString("Format error", comment: "Custom error")
    }
  }
}
