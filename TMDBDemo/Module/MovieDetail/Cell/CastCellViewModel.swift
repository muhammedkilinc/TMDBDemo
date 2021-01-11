//
//  CastCellViewModel.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 11.01.2021.
//

import Foundation

class CastCellViewModel   {
  
  let name: String
  let imageURL: URL?
  let character: String
  
  let cast: Cast
  
  init(with cast: Cast) {
    self.cast = cast
    self.name = cast.name ?? .empty
    self.character = cast.character ?? .empty
    
    self.imageURL = cast.profileImageURL
  }
}
