//
//  MockUserDefaultsService.swift
//  RxTodoTests
//
//  Created by 손병근 on 2021/05/15.
//

@testable import RxTodo

final class MockUserDefaultsService: UserDefaultServiceType {
  var store = [String: Any]()
  
  func value<T>(forKey key: UserDefaultsKey<T>) -> T? {
    return self.store[key.key] as? T
  }
  
  func set<T>(value: T?, forKey key: UserDefaultsKey<T>) {
    if let value = value {
      self.store[key.key] = value
    } else {
      self.store.removeValue(forKey: key.key)
    }
  }
  
  
}
