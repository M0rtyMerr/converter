//
//  ConverterDto.swift
//  CurrencyConverter
//
//  Created by Антон Назаров on 16/03/2018.
//  Copyright © 2018 Electrolux. All rights reserved.
//

struct ConvertDto: Codable {
  let success: Bool
  let result: String

  private enum CodingKeys: String, CodingKey {
    case success
    case result
  }
}
