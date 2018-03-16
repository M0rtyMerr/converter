//
//  ConvertAction.swift
//  CurrencyConverter
//
//  Created by Антон Назаров on 15/03/2018.
//  Copyright © 2018 Electrolux. All rights reserved.
//

enum ConverterAction {
  case changeState(from: String, to: String, amount: String, changedBy: Amount)
}
