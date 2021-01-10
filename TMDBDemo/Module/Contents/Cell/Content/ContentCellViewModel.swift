//
//  ContentCellViewModel.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 9.01.2021.
//

import Foundation

class ContentCellViewModel   {
  
  let title: String
  let imageURL: URL?
  let overview: String
  let subtitle: String

  let content: Content
  
  init(with content: Content) {
    self.content = content
    self.title = content.title ?? .empty
    self.overview = content.overview ?? .empty
   
    var subtitle: String = .empty
    if let type = content.mediaType {
      subtitle.append("Media: \(type.rawValue)\n")
    }
    if let vote = content.voteAverage {
      subtitle.append("Vote: \(vote)\n")
    }
    if let releaseDate = content.releaseDate {
      subtitle.append("Date: \(releaseDate)\n")
    }
    
    self.subtitle = subtitle
    self.imageURL = content.posterImageURL    
  }
}
