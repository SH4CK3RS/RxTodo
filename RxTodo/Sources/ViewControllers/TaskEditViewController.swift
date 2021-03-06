//
//  TaskEditViewController.swift
//  RxTodo
//
//  Created by 손병근 on 2021/07/12.
//

import UIKit
import ReactorKit
import RxSwift

final class TaskEditViewController: BaseViewController, View {
  
  struct Metric {
    static let padding = 15.f
    static let titleInputCornerRadius = 5.f
    static let titleInputBorderWidth = 1 / UIScreen.main.scale
  }
  
  struct Font {
    static let titleLabel = UIFont.systemFont(ofSize: 14)
  }

  struct Color {
    static let titleInputBorder = UIColor.lightGray
  }

  let cancelButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
  let doneButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
  let titleInput = UITextField().then {
    $0.autocorrectionType = .no
    $0.borderStyle = .roundedRect
    $0.font = Font.titleLabel
    $0.placeholder = "Do something..."
  }
  
  init(reactor: TaskEditViewReactor) {
    super.init()
    self.navigationItem.leftBarButtonItem = self.cancelButtonItem
    self.navigationItem.rightBarButtonItem = self.doneButtonItem
    self.reactor = reactor
  }
  
  required convenience init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    self.view.addSubview(self.titleInput)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.titleInput.becomeFirstResponder()
    
  }
  
  override func setupConstraints() {
    self.titleInput.snp.makeConstraints {
      $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(Metric.padding)
      $0.left.equalTo(Metric.padding)
      $0.right.equalTo(-Metric.padding)
    }
  }
  func bind(reactor: TaskEditViewReactor) {
    self.cancelButtonItem.rx.tap
      .map { Reactor.Action.cancel }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
    
    self.doneButtonItem.rx.tap
      .map { Reactor.Action.submit }
      .bind(to: reactor.action )
      .disposed(by: self.disposeBag)
    
    self.titleInput.rx.text.orEmpty
      .filter { !$0.isEmpty }
      .skip(1)
      .map( Reactor.Action.updateTaskTitle)
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
    
    reactor.state.asObservable()
      .map {$0.title}
      .distinctUntilChanged()
      .bind(to: self.navigationItem.rx.title )
      .disposed(by: self.disposeBag)
    
    reactor.state.asObservable()
      .map { $0.taskTitle }
      .distinctUntilChanged()
      .bind(to: self.titleInput.rx.text)
      .disposed(by: self.disposeBag)
    
    reactor.state.asObservable()
      .map { $0.canSubmit }
      .distinctUntilChanged()
      .bind(to: self.doneButtonItem.rx.isEnabled)
      .disposed(by: self.disposeBag)
    
    reactor.state.asObservable()
      .map { $0.isDismissed }
      .distinctUntilChanged()
      .filter { $0 }
      .subscribe(onNext: { [weak self] _ in
        self?.dismiss(animated: true, completion: nil)
      })
      .disposed(by: self.disposeBag)
  }
}
