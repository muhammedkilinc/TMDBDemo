//
//  PersonDetailViewModel.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 11.01.2021.
//

import Foundation
import RxSwift
import RxCocoa

class PersonDetailViewModel: ViewModelType {
  private let person: Person
  private let navigator: PersonDetailNavigator
  private let endpoint: Endpoint
  
  private let reloadRelay: PublishRelay<Void> = PublishRelay()
  
  init(endpoint: Endpoint, person: Person, navigator: PersonDetailNavigator) {
    self.person = person
    self.navigator = navigator
    self.endpoint = endpoint
  }
  
  func transform(input: Input) -> Output {
    
    let source = input.refresh.flatMap { _ in
      return self.endpoint.personDetail(personId: self.person.id)
    }
    
    return Output(person: source)
  }
  
}

extension PersonDetailViewModel {
  struct Input {
    let refresh: Observable<Void>
  }
  
  struct Output {
    let person: Observable<PersonDetail>
  }
}
