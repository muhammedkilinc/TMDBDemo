//
//  ContentsViewModel.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 9.01.2021.
//

import Foundation

import RxSwift
import RxCocoa

class ContentsViewModel: ViewModelType {
  
  private let navigator: ContentsNavigator
  private let endpoint: Endpoint
  private let disposeBag: DisposeBag = DisposeBag()
  
  private let contentsRelay: PublishRelay<[Content]> = PublishRelay()
  private let loadingRelay: PublishRelay<Bool> = PublishRelay()
  private let infoRelay: PublishRelay<String?> = PublishRelay()

  private var page: Int = 1
  
  init(endpoint: Endpoint, navigator: ContentsNavigator) {
    self.endpoint = endpoint
    self.navigator = navigator
  }
  
  func transform(input: Input) -> Output {
    
    let inputSource = input.query
      .throttle(DispatchTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
      .distinctUntilChanged()
      .do(onNext: { query in
        if query.count < 2 {
          self.contentsRelay.accept([])
          self.infoRelay.accept(Constants.Messages.SearchMulti)
          self.loadingRelay.accept(false)
        }
      })
      .filter { query -> Bool in
        return query.count > 1
      }

    let requestSource = inputSource.map { query in
      return SearchMultiRequestEntity(query: query, page: self.page)
    }
    .do(onNext: { query in
      self.loadingRelay.accept(true)
      self.infoRelay.accept(nil)
    })
    
    let networkSource = requestSource.concatMap { requestEntity in
      return self.endpoint.searchMulti(payload: requestEntity)
    }.map { response -> [Content] in
      let data = response.data ?? []
      return data
    }.do(onNext: { data in
      if data.isEmpty {
        self.infoRelay.accept(Constants.Messages.DataNotFound)
      }
      self.loadingRelay.accept(false)
    }).subscribe(on: MainScheduler.asyncInstance)
    .observe(on: MainScheduler.instance)
    
    input.pullToRefresh
      .do(onNext: { _ in
        self.page = 1
      }).concatMap { _ in
        return networkSource
      }.bind(to: contentsRelay)
      .disposed(by: disposeBag)
    
    networkSource.bind(to: contentsRelay)
      .disposed(by: disposeBag)
    
  
    input.selection
      .subscribe(onNext: { item in
        self.navigator.toDetail(item: item)
      })
      .disposed(by: disposeBag)
    
    return Output(contents: contentsRelay.asObservable(),
                  loading: loadingRelay.asObservable(),
                  info: infoRelay.asObservable())
    
  }

}

extension ContentsViewModel {
  
  struct Input {
    let query: Observable<String>
    let pullToRefresh: Observable<Void>
    let selection: Observable<Content>
  }
  
  struct Output {
    let contents: Observable<[Content]>
    let loading: Observable<Bool>
    var info: Observable<String?>
  }
  
}
