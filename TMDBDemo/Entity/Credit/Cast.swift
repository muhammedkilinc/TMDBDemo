//
//  Cast.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 11.01.2021.
//

import Foundation

struct Cast: Codable {
  let profilePath: String?
  let character: String?
  let name: String?
  let id: Int?
  
  private enum CodingKeys: String, CodingKey {
    case id
    case name
    case character
    case profilePath = "profile_path"
  }
}

//TODO: Create ImageUrlProvider
extension Cast {
  var profileImageURL: URL? {
    if let path = profilePath {
      return URL(string: "\(Constants.API.ImageBaseURL)\(path)")
    }
    return nil
  }
}

