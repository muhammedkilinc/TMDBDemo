//
//  AppDelegate.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 8.01.2021.
//

import UIKit
import Alamofire
import RxSwift

struct HTTPBinResponse: Decodable {
  let page: Int
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var disposable = Disposables.create()
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
//
    let source: Observable<HTTPBinResponse> = AF.request(Router.search(SearchMultiRequestEntity(query: "John", page: 1)).asURLRequest())
      .validate()
      .seralize()
  

    disposable = source
      .subscribe { (response) in
      debugPrint(response)
    }

    
    return true
  }



}

