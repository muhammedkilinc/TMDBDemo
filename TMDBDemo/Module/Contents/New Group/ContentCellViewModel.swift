//
//  ContentCellViewModel.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 9.01.2021.
//

import Foundation

class ContentCellViewModel   {
  let title: String
  
  let content: List
  
  init(with content: List) {
    self.content = content
    self.title = content.title ?? .empty
  }
}
