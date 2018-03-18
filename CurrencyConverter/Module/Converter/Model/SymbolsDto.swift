//
//  SymbolsDto.swift
//  CurrencyConverter
//
//  Created by Антон Назаров on 16/03/2018.
//  Copyright © 2018 Electrolux. All rights reserved.
//

struct SymbolsDto: Codable {
  let success: Bool
  let symbols: [String: String]

  private enum CodingKeys: String, CodingKey {
    case success
    case symbols
  }
}

