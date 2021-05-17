//
//  BaseTableViewCell.swift
//  RxTodo
//
//  Created by 손병근 on 2021/05/16.
//

import UIKit
import RxSwift

class BaseTableViewCell: UITableViewCell {
  var disposeBag: DisposeBag = DisposeBag()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.initialize()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func initialize() {
    //이걸 상속해서 사용하나봄. 취향에 맞게 구성해도 될듯
  }
}
