//
//  Checklist.swift
//  CoreDomain
//
//  Created by 현수빈 on 9/14/24.
//

import Foundation

public struct Checklist: Decodable, Equatable {
  public let id: Int
  public let createdTime: String
  public var title: String?
  public var checkBoxList: [CheckBox]
  
  public init(id: Int, createdTime: String, title: String?, checkBoxList: [CheckBox]) {
    self.id = id
    self.createdTime = createdTime
    self.title = title
    self.checkBoxList = checkBoxList
  }
  
  public init(id: Int) {
    self.init(
      id: id,
      createdTime: "",
      title: nil,
      checkBoxList: []
    )
  }
  
  enum CodingKeys: String, CodingKey {
    case id
    case createdTime
    case title
    case checkBoxList
  }
  
  public static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.id == rhs.id
  }
}

public extension Checklist {
  static let mock1 = Self(
    id: 1,
    createdTime: "",
    title: "디자인 시스템",
    checkBoxList: [
      .mock1,
      .mock2,
      .mock3,
      .mock4
    ]
  )
  
  static let mock2 = Self(
    id: 2,
    createdTime: "",
    title: "외주/거래처 협업",
    checkBoxList: [
      .mock5,
      .mock6,
      .mock7,
      .mock8
    ]
  )
}
