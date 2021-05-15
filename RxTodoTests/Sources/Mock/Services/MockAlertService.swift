//
//  MockAlertService.swift
//  RxTodoTests
//
//  Created by 손병근 on 2021/05/15.
//

import UIKit
@testable import RxTodo

import RxSwift
import Then

final class MockAlertService: BaseService, AlertServiceType, Then {
  
  var selectAction: AlertActionType?
  
  func show<Action: AlertActionType>(
    title: String?,
    message: String?,
    preferredStyle: UIAlertController.Style,
    actions: [Action]
  ) -> Observable<Action> {
    guard let selectAction = self.selectAction as? Action else { return .empty() }
    return .just(selectAction)
    
  }
}
