//
//  ServiceProvider.swift
//  RxTodo
//
//  Created by 손병근 on 2021/05/15.
//

protocol ServiceProviderType: class {
  var userDefaultsService: UserDefaultServiceType { get }
  var alertService: AlertServiceType { get }
  var taskService: TaskServiceType { get }
}

class ServiceProvider: ServiceProviderType {
  lazy var userDefaultsService: UserDefaultServiceType = UserDefaultService()
  lazy var alertService: AlertServiceType = AlertService(provider: self)
  lazy var taskService: TaskServiceType = TaskService(provider: self)
}
