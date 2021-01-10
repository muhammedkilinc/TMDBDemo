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
  case personDetail(Int)

}

extension EndpointRequestable {
  var method: HTTPMethod {
    switch self {
    case .search: return .get
    case .movieDetail: return .get
    case .personDetail: return .get
    }
  }
  
  var path: String {
    switch self {
    case .search: return "/search/multi"
    case let .movieDetail(movieId): return "/movie/\(movieId)"
    case let .personDetail(personId): return "/person/\(personId)"

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
    default:
      break
    }
    
    return request
  }
  
  var extraParams: [String : Any]?  {
    switch self {
    case .movieDetail:
      return ["append_to_response": "videos,credits"]
    case .personDetail:
      return ["append_to_response": "credits"]
    default:
      return nil
    }
  }

}
