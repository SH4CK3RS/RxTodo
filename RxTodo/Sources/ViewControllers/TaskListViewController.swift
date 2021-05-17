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
  
  let dataSource = RxTableViewSectionedReloadDataSource<TaskListSection> { datasource, tableView, indexPath, reactor -> UITableViewCell in
    let cell = tableView.dequeue(Reusable.taskCell, for: indexPath)
    cell.reactor = reactor
    return cell
  }
  
  let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
  let tableView = UITableView().then {
    $0.allowsSelectionDuringEditing = true
    $0.register(Reusable.taskCell)
  }
  
  

  init(reactor: TaskListViewReactor) {
    super.init()
    self.navigationItem.leftBarButtonItem = self.editButtonItem
    self.navigationItem.rightBarButtonItem = self.addButtonItem
    self.reactor = reactor
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    self.view.addSubview(tableView)
  }
  
  override func setupConstraints() {
    super.setupConstraints()
    self.tableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  func bind(reactor: TaskListViewReactor) {
    self.tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
    self.dataSource.canEditRowAtIndexPath = { _, _ in true }
    self.dataSource.canMoveRowAtIndexPath = { _, _ in true }
    
    self.rx.viewDidLoad
      .map { .refresh }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
    
    self.editButtonItem.rx.tap
      .map { .toggleEditing }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
    
    self.tableView.rx.itemSelected
      .filter({ _ in !reactor.currentState.isEditing })
      .map(Reactor.Action.toggleTaskDone)
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
    
    self.tableView.rx.itemDeleted
      .map(Reactor.Action.deleteTask)
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
    
    self.tableView.rx.itemMoved
      .map(Reactor.Action.moveTask)
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
  }
  
  
  
}

extension TaskListViewController: UITableViewDelegate {
  
}
