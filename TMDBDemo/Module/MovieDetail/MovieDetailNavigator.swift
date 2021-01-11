//
//  MovieDetailNavigator.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 10.01.2021.
//

import UIKit

protocol MovieDetailNavigator {
  func toMovies()
}

final class MovieDetailNavigatorImp: MovieDetailNavigator {
  private let navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func toMovies() {
    navigationController.popViewController(animated: true)
  }
}
