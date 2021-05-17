//
//  TaskCell.swift
//  RxTodo
//
//  Created by 손병근 on 2021/05/16.
//

import UIKit

import ReactorKit
import RxSwift
import SnapKit

final class TaskCell: BaseTableViewCell, View {
  typealias Reactor = TaskCellReactor
  
  struct Constant {
    static let titleLabelNumberOfLines = 2
  }

  struct Metric {
    static let cellPadding = 15.f
  }

  struct Font {
    static let titleLabel = UIFont.systemFont(ofSize: 14)
  }

  struct Color {
    static let titleLabelText = UIColor.black
  }
  
  let titleLabel = UILabel().then {
    $0.font = Font.titleLabel
    $0.textColor = Color.titleLabelText
    $0.numberOfLines = Constant.titleLabelNumberOfLines
  }
  
  override func initialize() {
    self.contentView.addSubview(self.titleLabel)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.titleLabel.top = Metric.cellPadding
    self.titleLabel.left = Metric.cellPadding
    self.titleLabel.width = self.contentView.width - Metric.cellPadding * 2
    self.titleLabel.sizeToFit()
  }
  
  func bind(reactor: Reactor) {
    self.titleLabel.text = reactor.currentState.title
    self.accessoryType = reactor.currentState.isDone ? .checkmark : .none
  }
  
  class func height(fits width: CGFloat, reactor: Reactor) -> CGFloat {
    let height = reactor.currentState.title.height(
      fits: width,
      font: Font.titleLabel,
      maximumNumberOfLines: Constant.titleLabelNumberOfLines
    )
    
    return height + Metric.cellPadding * 2
  }
}
