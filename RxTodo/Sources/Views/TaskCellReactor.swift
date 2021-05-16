//
//  TaskCellReactor.swift
//  RxTodo
//
//  Created by 손병근 on 2021/05/16.
//

import ReactorKit
import RxCocoa
import RxSwift

class TaskCellReactor: Reactor {
  typealias Action = NoAction
  
  let initialState: Task
  
  init(task: Task) {
    self.initialState = task
  }
}
