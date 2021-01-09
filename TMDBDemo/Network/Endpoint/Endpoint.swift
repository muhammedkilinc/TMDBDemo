//
//  Endpoint.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 9.01.2021.
//

import Foundation
import Alamofire

protocol Endpoint {
  
  var baseURL: String { get }
  var path: String { get }
  var headers: [String: String] { get }
  var additionalParams: [String: Any] { get }
  var method: HTTPMethod { get }
}

extension Endpoint {
  
  var baseURL: String {
    return Constants.API.BaseURL
  }
  
  var apiKey: String {
    return Constants.API.APIKey
  }
  
  var version: String {
    return "/3"
  }
  
  var headers: [String : String] {
    return [:]
  }
  
  var additionalParams: [String : Any] {
    return ["language": "en",
            "include_adult": true,
            "api_key": apiKey]
  }
  
  var urlComponents: URLComponents {
    guard var components = URLComponents(string: baseURL) else {
      fatalError("URLComponents cannot be created")
    }
    components.path = version + path

    var queryItems: [URLQueryItem] = []

    let params = additionalParams.map({ (key, value) -> URLQueryItem in
      return URLQueryItem(name: "\(key)", value: "\(value)")
    })

    queryItems.append(contentsOf: params)
    
    components.queryItems = queryItems
    return components
  }
}

