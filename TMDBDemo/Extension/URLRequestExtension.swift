//
//  URLRequestExtension.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 9.01.2021.
//

import Foundation
import Alamofire
import RxSwift

extension URLRequest {
  
  public func perform<T>() -> Observable<T> where T: Decodable {
    return AF.request(self).seralize().debug()
  }
  
}
