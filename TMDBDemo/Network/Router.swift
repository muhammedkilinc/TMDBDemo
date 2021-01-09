//
//  Router.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 9.01.2021.
//

import Foundation
import Alamofire

enum Router: Endpoint {
  
  case search(SearchMultiRequestEntity)
  
}

extension Router {
  var method: HTTPMethod {
    switch self {
    case .search: return .get
    }
  }
  
  var path: String {
    switch self {
    case .search: return "/search/multi"
    }
  }
  
  func asURLRequest() -> URLRequest {
    var request = URLRequest(url: urlComponents.url!)
    
    for (key, value) in headers {
      request.setValue(key, forHTTPHeaderField: value)
    }
    
    switch self {
    case let .search(parameters):
      request = try! URLEncodedFormParameterEncoder().encode(parameters, into: request)
    }
    
    return request
  }
}
