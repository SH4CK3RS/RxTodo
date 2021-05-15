//
//  BaseService.swift
//  RxTodo
//
//  Created by 손병근 on 2021/05/15.
//

class BaseService {
  unowned let provider: ServiceProviderType
  
  init(provider: ServiceProviderType) {
    self.provider = provider
  }
}
