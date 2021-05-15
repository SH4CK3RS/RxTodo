//
//  UserDefaultKey.swift
//  RxTodo
//
//  Created by 손병근 on 2021/05/15.
//

import Foundation

/// `UserDefaults`를 위한 generic key로. 커스텀 유저디폴트 키를 위해 사용하는 타입.
///
/// ```
/// extension UserDefaultsKey {
///   static var myKey: Key<String> {
///     return "myKey"
///   }
///
///   static var anotherKey: Key<Int> {
///     return "anotherKey"
///   }
/// }
/// ```
struct UserDefaultsKey<T> {
  typealias Key<T> = UserDefaultsKey<T>
  let key: String
}

extension UserDefaultsKey: ExpressibleByStringLiteral {
  public init(unicodeScalarLiteral value: StringLiteralType) {
    self.init(key: value)
  }
  
  public init(extendedGraphemeClusterLiteral value: StringLiteralType) {
    self.init(key: value)
  }
  
  public init(stringLiteral value: StringLiteralType) {
    self.init(key: value)
  }
}
