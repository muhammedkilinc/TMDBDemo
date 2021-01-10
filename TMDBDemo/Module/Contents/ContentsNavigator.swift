//
//  ContentsNavigator.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 9.01.2021.
//

import UIKit

protocol ContentsNavigator {
  func toContents()
  func toDetail(item: Content)
}

class ContentsNavigatorImp: ContentsNavigator {
  
  private let navigationController: UINavigationController
  private let endpoint: Endpoint
  
  init(endpoint: Endpoint,
       navigationController: UINavigationController) {
    self.endpoint = endpoint
    self.navigationController = navigationController
  }
  
  func toContents() {
    let vc = ContentsViewController.loadFromNib()
    vc.viewModel = ContentsViewModel(endpoint: endpoint, navigator: self)
    navigationController.pushViewController(vc, animated: true)
  }
  
  func toDetail(item: Content) {
    if item.mediaType == .movie {
      let navigator = MovieDetailNavigatorImp(navigationController: navigationController)
      let viewModel = MovieDetailViewModel(endpoint: endpoint, movie: item.toMovie(), navigator: navigator)
      let vc = MovieDetailViewController.loadFromNib()
      vc.viewModel = viewModel
      navigationController.pushViewController(vc, animated: true)
    } else if item.mediaType == .person {
      let navigator = PersonDetailNavigatorImp(navigationController: navigationController)
      let viewModel = PersonDetailViewModel(endpoint: endpoint, person: item.toPerson(), navigator: navigator)
      let vc = PersonDetailViewController.loadFromNib()
      vc.viewModel = viewModel
      navigationController.pushViewController(vc, animated: true)
    } else {
      // TODO:
    }
    
  }
}
