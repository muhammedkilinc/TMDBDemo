//
//  PersonCellViewModel.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 10.01.2021.
//

import Foundation

class PersonCellViewModel   {
  
  let name: String
  let imageURL: URL?
  let popularity: String
  
  let content: Content
  
  init(with content: Content) {
    self.content = content
    self.name = content.name ?? .empty
    self.popularity = "Popularity: \(content.popularity ?? 0)"
    
    self.imageURL = content.profileImageURL
  }
}
