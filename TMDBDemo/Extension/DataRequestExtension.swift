//
//  DataRequestExtension.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 9.01.2021.
//

import Foundation
import Alamofire
import RxSwift

extension DataRequest {
  
  @discardableResult
  public func seralize<T: Decodable>(completionHandler: @escaping (AFDataResponse<T>) -> Void) -> Self {
    return responseDecodable(completionHandler: completionHandler)
  }
  
  public func seralize<T: Decodable>() -> Observable<T> {
    return Observable.create { emitter in
      let request = self.seralize { (data: AFDataResponse<T>) in
        switch data.result {
        case .success(let payload):
          emitter.onNext(payload)
          break
        case .failure(let error):
          emitter.onError(error)
          break
        }
        emitter.onCompleted()
      }
      
      return Disposables.create {
        request.cancel()
      }
    }
  }
}

