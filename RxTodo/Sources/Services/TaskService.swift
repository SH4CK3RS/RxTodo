//
//  TaskService.swift
//  RxTodo
//
//  Created by 손병근 on 2021/05/15.
//

import RxSwift

enum TaskEvent {
  case create(Task)
  case update(Task)
  case delete(id: String)
  case move(id: String, to: Int)
  case markAsDone(id: String)
  case markAsUndone(id: String)
}

protocol TaskServiceType {
  var event: PublishSubject<TaskEvent> { get }
  func fetchTasks() -> Observable<[Task]>
  
  @discardableResult
  func saveTask(_ tasks: [Task]) -> Observable<Void>
  
  func create(title: String, memo: String?) -> Observable<Task>
  func update(taskID: String, title: String, memo: String?) -> Observable<Task>
  func delete(taskID: String) -> Observable<Task>
  func move(taskID: String, to: Int) -> Observable<Task>
  func markAsDone(taskID: String) -> Observable<Task>
  func markAsUndone(taskID: String) -> Observable<Task>
  
}
