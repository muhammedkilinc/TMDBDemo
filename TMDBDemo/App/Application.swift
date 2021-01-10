//
//  Application.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 9.01.2021.
//

import UIKit

class Application {
  static let shared = Application()
  
  private let endpoint: Endpoint
  
  private init() {
    self.endpoint = EndpointImp()
  }
  
  func configureMainInterface(in window: UIWindow) {
    let networkNavigationController = UINavigationController()    
    let networkNavigator = ContentsNavigatorImp(endpoint: self.endpoint,
                                                navigationController: networkNavigationController)
    
    window.rootViewController = networkNavigationController
    
    networkNavigator.toContents()
  }
  
}
