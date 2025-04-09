//
//  Card.swift
//  FeatureHome
//
//  Created by 홍은표 on 9/24/24.
//

import Foundation

import CoreDomain

public struct Card: Identifiable, Hashable, Equatable {
  public let id: Int
  public let title: String
  public var checkBoxList: [CheckBox]
  public var percent: CGFloat = 0
  
  public init(id: Int, title: String?, checkBoxList: [CheckBox]) {
    self.id = id
    self.title = title ?? ""
    self.checkBoxList = checkBoxList
    calculatePercent()
  }
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  public static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.id == rhs.id
  }
  
  mutating public func calculatePercent() {
    let total = CGFloat(checkBoxList.count)
    let completed = CGFloat(checkBoxList.filter(\.isCompleted).count)
    let percent = total > 0 ? completed / total : 0
    self.percent = percent
  }
}
