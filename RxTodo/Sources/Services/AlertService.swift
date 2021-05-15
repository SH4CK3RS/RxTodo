//
//  AlertService.swift
//  RxTodo
//
//  Created by 손병근 on 2021/05/15.
//

import UIKit
import RxSwift

protocol AlertActionType {
  var title: String? { get }
  var style: UIAlertAction.Style { get }
}

extension AlertActionType {
  var style: UIAlertAction.Style {
    return .default
  }
}

protocol AlertServiceType {
  func show<Action: AlertActionType>(
    title: String?,
    message: String?,
    preferredStyle: UIAlertController.Style,
    actions: [Action]
  ) -> Observable<Action>
}
