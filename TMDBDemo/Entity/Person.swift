//
//  Person.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 9.01.2021.
//

import Foundation

struct Person: Codable, Equatable {
  
  let id: Int
  let name: String
  let profilePath: String?
  let popularity: Double?
  let knownFor: [Movie]?

  private enum CodingKeys: String, CodingKey {
    case id
    case name
    case profilePath = "profile_path"
    case popularity
    case knownFor = "known_for"
  }
}
