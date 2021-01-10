//
//  ListResponse.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 9.01.2021.
//

import Foundation

private let encoder = JSONEncoder()

struct ListResponse<T>: Codable, CustomStringConvertible where T: Codable {
  
  var data: T?
  var currentPage: Int?
  var totalPages: Int?
  var totalResults: Int?
  var errors: [String]?
  var statusMessage: String?
  var statusCode: Int?

  var description: String {
    get {
      do {
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(self)
        return String(data: data, encoding: .utf8) ?? "could not resolve \(ListResponse<T>.self)"
      } catch {
        return error.localizedDescription
      }
    }
  }
  
  enum CodingKeys: String, CodingKey {
    case data = "results"
    case currentPage = "page"
    case totalPages = "total_pages"
    case totalResults = "total_results"
    case statusMessage = "status_message"
    case statusCode = "status_code"
    case errors
  }
}
