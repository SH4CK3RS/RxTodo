//
//  ModelType.swift
//  RxTodo
//
//  Created by 손병근 on 2021/05/15.
//

import Then

protocol Identifiable {
  associatedtype Identifier: Equatable
  var id: Identifier { get }
}

protocol ModelType: Then {
  
}

extension Collection where Self.Iterator.Element: Identifiable {
  func index(of element: Self.Iterator.Element) -> Self.Index? {
    return self.firstIndex { $0.id == element.id }
  }
}
