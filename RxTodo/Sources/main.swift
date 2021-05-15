//
//  main.swift
//  RxTodo
//
//  Created by 손병근 on 2021/05/15.
//

import Foundation
import UIKit

final class MockAppDelegate: UIResponder, UIApplicationDelegate {}

private func appDelegateClassName() -> String {
  let isTesting = NSClassFromString("XCTestCase") != nil
  return NSStringFromClass(isTesting ? MockAppDelegate.self : AppDelegate.self)
}

_ = UIApplicationMain(
  CommandLine.argc,
  CommandLine.unsafeArgv,
  NSStringFromClass(UIApplication.self),
  appDelegateClassName()
)
