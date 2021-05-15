//
//  UserDefaultsService.swift
//  RxTodo
//
//  Created by 손병근 on 2021/05/15.
//

import Foundation

extension UserDefaultsKey {
  static var tasks: Key<[[String: Any]]> { return "tasks" }
}

protocol UserDefaultServiceType {
  func value<T>(forKey key: UserDefaultsKey<T>) -> T?
  func set<T>(value: T?, forKey key: UserDefaultsKey<T>)
}


final class UserDefaultService: UserDefaultServiceType{
  private var defaults: UserDefaults {
    return UserDefaults.standard
  }
  
  func value<T>(forKey key: UserDefaultsKey<T>) -> T? {
    return self.defaults.value(forKey: key.key) as? T
  }
  
  func set<T>(value: T?, forKey key: UserDefaultsKey<T>) {
    self.defaults.setValue(value, forKey: key.key)
  }
}
