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

  init(endpoint: Endpoint, navigator: ContentsNavigator) {
    self.endpoint = endpoint
    self.navigator = navigator
  }
  
  func transform(input: Input) -> Output {
    
    return Output()
  }

}

extension ContentsViewModel {
  
  struct Input {
    let query: Driver<String>
  }
  
  struct Output {
  }
  
}
