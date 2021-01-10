//
//  MovieDetailViewModel.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 10.01.2021.
//

import Foundation
import RxSwift
import RxCocoa

class MovieDetailViewModel: ViewModelType {
  private let movie: Movie
  private let navigator: MovieDetailNavigator
  private let endpoint: Endpoint
  
  private let reloadRelay: PublishRelay<Void> = PublishRelay()

  init(endpoint: Endpoint, movie: Movie, navigator: MovieDetailNavigator) {
    self.movie = movie
    self.navigator = navigator
    self.endpoint = endpoint
  }
  
  func transform(input: Input) -> Output {
    
    let source = input.refresh.flatMap { _ in
      return self.endpoint.movieDetail(movieId: self.movie.id)
    }
    
    return Output(movie: source)
  }
  
}

extension MovieDetailViewModel {
  struct Input {
    let refresh: Observable<Void>
  }
  
  struct Output {
    let movie: Observable<MovieDetail>
  }
}
