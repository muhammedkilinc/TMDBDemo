//
//  PersonDetailNavigator.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 11.01.2021.
//

import UIKit

protocol PersonDetailNavigator {
  func toPersons()
}

final class PersonDetailNavigatorImp: PersonDetailNavigator {
  private let navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func toPersons() {
    navigationController.popViewController(animated: true)
  }
}
