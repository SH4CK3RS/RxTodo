//
//  TaskListViewController.swift
//  RxTodo
//
//  Created by 손병근 on 2021/05/16.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa
import ReusableKit
import RxDataSources

class TaskListViewController: BaseViewController, View {
  
  struct Reusable {
    static let taskCell = ReusableCell<TaskCell>()
  }
  
  func bind(reactor: TaskListViewReactor) {
    self.rx.viewDidLoad
      .map { Reactor.Action.refresh }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
  }

  init(reactor: TaskListViewReactor) {
    super.init()
    self.reactor = reactor
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  let dataSource = RxTableViewSectionedReloadDataSource<TaskListSection> { datasource, tableView, indexPath, reactor -> UITableViewCell in
    let cell = tableView.dequeue(Reusable)
  }
  
}
