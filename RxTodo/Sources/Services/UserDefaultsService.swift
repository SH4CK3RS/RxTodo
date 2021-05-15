//
//  UserDefaultsService.swift
//  RxTodo
//
//  Created by 손병근 on 2021/05/15.
//

import Foundation

protocol UserDefaultServiceType {
  func value<T>(forKey key: UserDefaultsKey<T>) -> T?
  func set<T>(value: T?, forKey key: UserDefaultsKey<T>)
}


