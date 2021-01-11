//
//  Crew.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 11.01.2021.
//

import Foundation

struct Crew: Codable {
  let department: String?
  let job: String?
  let name: String?
  let profilePath: String?
  
  private enum CodingKeys: String, CodingKey {
    case department
    case job
    case name
    case profilePath = "profile_path"
  }
}

//TODO: Create ImageUrlProvider
extension Crew {
  var profileImageURL: URL? {
    if let path = profilePath {
      return URL(string: "\(Constants.API.ImageBaseURL)\(path)")
    }
    return nil
  }
}
