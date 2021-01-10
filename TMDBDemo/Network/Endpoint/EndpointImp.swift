//
//  SearchClientImp.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 9.01.2021.
//

import Foundation
import RxSwift

class EndpointImp: Endpoint {
  
  func searchMulti(payload: SearchMultiRequestEntity) -> Observable<ListResponse<[Content]>> {
    let method = EndpointRequestable.search(payload)
    return method.asURLRequest().perform()
  }
  
  func movieDetail(movieId: Int) -> Observable<MovieDetail> {
    let method = EndpointRequestable.movieDetail(movieId)
    return method.asURLRequest().perform()
  }
  
  func personDetail(personId: Int) -> Observable<PersonDetail> {
    let method = EndpointRequestable.personDetail(personId)
    return method.asURLRequest().perform()
  }
}

//
//extension ObservableType {
//  func applyResult<T>() -> Observable<Result<T, Error>> where ListResponse<T> == Element {
//    return self.map { response in
//      if let data = response.data {
//        return .success(data)
//      } else {
//        //TODO: Check errors parameter
//        return .failure(APIError.responseError(response.statusMessage ?? ""))
//      }
//    }
//  }
//}
//
//enum APIError: Error {
//  case responseError(String)
//}
