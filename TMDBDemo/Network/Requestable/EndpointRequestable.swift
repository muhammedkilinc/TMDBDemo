//
//  Router.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 9.01.2021.
//

import Foundation
import Alamofire

enum EndpointRequestable: Requestable {
  
  case search(SearchMultiRequestEntity)
  case movieDetail(Int)
}

extension EndpointRequestable {
  var method: HTTPMethod {
    switch self {
    case .search: return .get
    case .movieDetail: return .get
    }
  }
  
  var path: String {
    switch self {
    case .search: return "/search/multi"
    case let .movieDetail(movieId): return "/movie/\(movieId)"
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
    case .movieDetail(_):
      break
    }
    
    return request
  }
}
