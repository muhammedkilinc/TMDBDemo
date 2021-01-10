//
//  Constants.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 9.01.2021.
//

import UIKit

struct Constants {
  
  struct API {
    static let BaseURL = "https://api.themoviedb.org"
    static let APIKey = "c0153cc86c5d7e821fb66d3f3d202122"
    static let ImageBaseURL = "https://image.tmdb.org/t/p/w500"
  }
  
  struct Screen {
    static let ContentsTitle = "Movie"
    static let SearchPlaceholder = "Search"
    static let CellSpacing: CGFloat = 12
  }
  
  struct Messages {
    static let DataNotFound = "No Results"
    static let SearchMulti = "Search movies, TV or Person in THE MOVIE DB"
  }
  
}
