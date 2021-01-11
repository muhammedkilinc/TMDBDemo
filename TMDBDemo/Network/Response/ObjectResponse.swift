//
//  ObjectResponse.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 10.01.2021.
//

import Foundation

struct ObjectResponse<T>: Codable where T: Codable {  
  
  var data: T?
  var errors: [String]?
  var statusMessage: String?
  var statusCode: Int?
    
  enum CodingKeys: String, CodingKey {
    case data = "results"
    case statusMessage = "status_message"
    case statusCode = "status_code"
    case errors
  }
}
