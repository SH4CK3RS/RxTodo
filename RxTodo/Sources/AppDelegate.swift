//
//  AppDelegate.swift
//  RxTodo
//
//  Created by 손병근 on 2021/05/15.
//

import UIKit
import RxViewController
import CGFloatLiteral
import ManualLayout

class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.backgroundColor = .white
    window.makeKeyAndVisible()
  
    let serviceProvider = ServiceProvider()
    let reactor = TaskListViewReactor(provider: serviceProvider)
    let viewController = TaskListViewController(reactor: reactor)
    let navigationController = UINavigationController(rootViewController: viewController)
    
    window.rootViewController = navigationController
    
    self.window = window
    return true
  }

}

