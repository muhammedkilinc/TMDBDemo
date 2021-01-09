//
//  SearchClientImp.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 9.01.2021.
//

import Foundation
import RxSwift

class EndpointImp: Endpoint {
  
  func searchMulti(payload: SearchMultiRequestEntity) -> Observable<ListResponse<[List]>> {
    let method = EndpointRequestable.search(payload)
    return method.asURLRequest().perform()
  }
  
}

