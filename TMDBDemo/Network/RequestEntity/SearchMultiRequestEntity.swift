//
//  SearchMultiRequestEntity.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 9.01.2021.
//

import Foundation

struct SearchMultiRequestEntity: Codable {
  let query: String
  let page: Int
}

