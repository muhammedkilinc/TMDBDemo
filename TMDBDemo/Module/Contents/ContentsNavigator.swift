//
//  ContentsNavigator.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 9.01.2021.
//

import UIKit

protocol ContentsNavigator {
  func toContents()
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

}
