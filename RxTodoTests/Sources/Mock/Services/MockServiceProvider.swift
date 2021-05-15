//
//  MockServiceProvider.swift
//  RxTodoTests
//
//  Created by 손병근 on 2021/05/15.
//

@testable import RxTodo

final class MockServiceProvider: ServiceProviderType {
  lazy var userDefaultsService: UserDefaultServiceType = MockUserDefaultsService()
  lazy var alertService: AlertServiceType = MockAlertService(provider: self)
}
