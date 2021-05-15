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
  func saveTasks(_ tasks: [Task]) -> Observable<Void>
  
  func create(title: String, memo: String?) -> Observable<Task>
  func update(taskID: String, title: String, memo: String?) -> Observable<Task>
  func delete(taskID: String) -> Observable<Task>
  func move(taskID: String, to: Int) -> Observable<Task>
  func markAsDone(taskID: String) -> Observable<Task>
  func markAsUndone(taskID: String) -> Observable<Task>
  
}

final class TaskService: BaseService, TaskServiceType {
  var event = PublishSubject<TaskEvent>()
  
  func fetchTasks() -> Observable<[Task]> {
    if let savedDictionaries = self.provider.userDefaultsService.value(forKey: .tasks) {
      let tasks = savedDictionaries.compactMap(Task.init)
      return .just(tasks)
    }
    let defaultTasks: [Task] = [
      Task(title: "Go to https://github.com/SH4CK3RS"),
      Task(title: "Star UniPlogger Repository"),
      Task(title: "fix a bug")
    ]
    let defaultDictionaries = defaultTasks.map { $0.asDictionary() }
    self.provider.userDefaultsService.set(value: defaultDictionaries, forKey: .tasks)
    return .just(defaultTasks)
  }
  
  @discardableResult
  func saveTasks(_ tasks: [Task]) -> Observable<Void> {
    let dics = tasks.map { $0.asDictionary() }
    self.provider.userDefaultsService.set(value: dics, forKey: .tasks)
    return .just(())
  }
  
  func create(title: String, memo: String?) -> Observable<Task> {
    return self.fetchTasks()
      .flatMap { [weak self] tasks -> Observable<Task> in
      guard let self = self else { return .empty() }
      let newTask = Task(title: title, memo: memo)
      return self.saveTasks(tasks + [newTask]).map { newTask }
      }.do(onNext: {
        self.event.onNext(.create($0))
      })
  }
  
  func update(taskID: String, title: String, memo: String?) -> Observable<Task> {
    return self.fetchTasks()
      .flatMap { [weak self] tasks -> Observable<Task> in
        guard let self = self else { return .empty() }
        guard let index = tasks.firstIndex(where: { $0.id == taskID }) else { return .empty() }
        var tasks = tasks
        let newTask = tasks[index].with {
          $0.title = title
          $0.memo = memo
        }
        tasks[index] = newTask
        return self.saveTasks(tasks).map { newTask }
      }.do(onNext: {
        self.event.onNext(.update($0))
      })
  }
  
  func delete(taskID: String) -> Observable<Task> {
    return self.fetchTasks()
      .flatMap { [weak self] tasks -> Observable<Task> in
        guard let self = self else { return .empty() }
        guard let index = tasks.firstIndex(where: { $0.id == taskID }) else { return .empty() }
        var tasks = tasks
        let deletedTask = tasks.remove(at: index)
        return self.saveTasks(tasks).map { deletedTask }
      }.do(onNext: {
        self.event.onNext(.delete(id: $0.id))
      })
  }
  
  func move(taskID: String, to destinationIndex: Int) -> Observable<Task> {
    return self.fetchTasks()
      .flatMap { [weak self] tasks -> Observable<Task> in
        guard let self = self else { return .empty() }
        guard let index = tasks.firstIndex(where: { $0.id == taskID }) else { return .empty()}
        var tasks = tasks
        let task = tasks.remove(at: index)
        tasks.insert(task, at: destinationIndex)
        return self.saveTasks(tasks).map { task }
      }.do(onNext: {
        self.event.onNext(.move(id: $0.id, to: destinationIndex))
      })
  }
  
  func markAsDone(taskID: String) -> Observable<Task> {
    return self.fetchTasks()
      .flatMap { [weak self] tasks -> Observable<Task> in
        guard let self = self else { return .empty() }
        guard let index = tasks.firstIndex(where: { $0.id == taskID }) else { return .empty()}
        var tasks = tasks
        let task = tasks[index].with {
          $0.isDone = true
        }
        tasks[index] = task
        return self.saveTasks(tasks).map { task }
      }.do(onNext: {
        self.event.onNext(.markAsDone(id: $0.id))
      })
  }
  
  func markAsUndone(taskID: String) -> Observable<Task> {
    return self.fetchTasks()
      .flatMap { [weak self] tasks -> Observable<Task> in
        guard let self = self else { return .empty() }
        guard let index = tasks.firstIndex(where: { $0.id == taskID }) else { return .empty()}
        var tasks = tasks
        let task = tasks[index].with {
          $0.isDone = false
        }
        tasks[index] = task
        return self.saveTasks(tasks).map { task }
      }.do(onNext: {
        self.event.onNext(.markAsUndone(id: $0.id))
      })
  }
  
}
