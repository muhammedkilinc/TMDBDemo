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
    
    //input'u relaye at
    //relayi outputla paylaş
    //output data relay
    //Output data relay tableview datasource'a bind et.
    //

    return true
  }



}

