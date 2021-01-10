//
//  MovieDetail.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 10.01.2021.
//

import Foundation

struct MovieDetail: Codable {
  let id: Int
  let title: String?
  let backdropPath: String?
  let posterPath: String?
  let overview: String?
  let releaseDate: String?
  let voteAverage: Double?
  let voteCount: Int?
  let tagline: String?
  let genres: [MovieGenre]?
  let adult: Bool?
  let runtime: Int?
  let popularity: Double?

  private enum CodingKeys: String, CodingKey {
    case id
    case title
    case overview
    case genres
    case posterPath = "poster_path"
    case backdropPath = "backdrop_path"
    case releaseDate = "release_date"
    case voteAverage = "vote_average"
    case adult
    case runtime
    case tagline
    case popularity
    case voteCount = "vote_count"

  }
}

extension MovieDetail {
  var posterImageURL: URL? {
    if let path = posterPath {
      return URL(string: "\(Constants.API.ImageBaseURL)\(path)")
    }
    return nil
  }
}
