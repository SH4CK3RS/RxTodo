//
//  ServiceProvider.swift
//  RxTodo
//
//  Created by 손병근 on 2021/05/15.
//

protocol ServiceProviderType: class {
  var userDefaultsService: UserDefaultServiceType { get }
}
