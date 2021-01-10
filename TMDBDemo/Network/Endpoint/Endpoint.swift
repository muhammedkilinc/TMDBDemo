//
//  SearchClient.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 9.01.2021.
//

import Foundation
import RxSwift

protocol Endpoint {
  
  func searchMulti(payload: SearchMultiRequestEntity) -> Observable<ListResponse<[Content]>>
  func movieDetail(movieId: Int) -> Observable<MovieDetail>

}
