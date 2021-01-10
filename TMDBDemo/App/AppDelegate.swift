//
//  AppDelegate.swift
//  TMDBDemo
//
//  Created by Muhammed Kılınç on 8.01.2021.
//

import UIKit
import Alamofire
import RxSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var disposable = Disposables.create()
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
//
//    let source: Observable<ListResult> = AF.request(Router.search(SearchMultiRequestEntity(query: "John", page: 1)).asURLRequest())
//      .validate()
//      .seralize()
//
//
//    disposable = source
//      .subscribe { (response) in
//      debugPrint(response)
//    }
    
    let source: Observable<ListResponse<[List]>> = EndpointImp().searchMulti(payload: SearchMultiRequestEntity(query: "John", page: 1))
    
    disposable = source
      .subscribe { (response) in
        debugPrint(response)
      }
    
    let window = UIWindow(frame: UIScreen.main.bounds)
    Application.shared.configureMainInterface(in: window)
    self.window = window
    
    self.window?.makeKeyAndVisible()
    
    return true
  }



}

