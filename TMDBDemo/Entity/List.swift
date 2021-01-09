//
//  List.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 9.01.2021.
//

import Foundation

struct List: Codable, Equatable {
  
  let id: Int
  let title: String?
  let genreIds: [Int]?
  let overview: String?
  let posterPath: String?
  let backdropPath: String?
  let releaseDate: String?
  let voteAverage: Double?
  let name: String?
  let mediaType: MediaType?
  let knownFor: [Movie]?
  
  private enum CodingKeys: String, CodingKey {
    case id
    case title
    case overview
    case name
    case genreIds = "genre_ids"
    case posterPath = "poster_path"
    case backdropPath = "backdrop_path"
    case releaseDate = "release_date"
    case voteAverage = "vote_average"
    case mediaType = "media_type"
    case knownFor = "known_for"
    
  }
}
