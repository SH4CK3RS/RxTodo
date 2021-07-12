//
//  BaseViewController.swift
//  RxTodo
//
//  Created by 손병근 on 2021/05/16.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    super.init(nibName: nil, bundle: nil)
  }
  
  var disposeBag = DisposeBag()
  
  fileprivate(set) var didUpdateConstraints = false
  
  override func viewDidLoad() {
    self.view.setNeedsUpdateConstraints()
  }
  
  override func updateViewConstraints() {
    if !self.didUpdateConstraints {
      self.setupConstraints()
      self.didUpdateConstraints = true
    }
    super.updateViewConstraints()
  }
  
  func setupConstraints() {
    
  }
  
  
}
