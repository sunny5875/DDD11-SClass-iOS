//
//  CheckBox.swift
//  CoreDomain
//
//  Created by 현수빈 on 9/8/24.
//

import Foundation

public struct CheckBox: Decodable, Identifiable, Equatable, Hashable {
  public let id: Int
  public let checklistId: Int
  public var content: String
  public var isCompleted: Bool
  public let createdAt: String
  public let updatedAt: String
  
  public init(
    id: Int,
    checklistId: Int,
    content: String,
    isCompleted: Bool,
    createdAt: String,
    updatedAt: String
  ) {
    self.id = id
    self.checklistId = checklistId
    self.content = content
    self.isCompleted = isCompleted
    self.createdAt = createdAt
    self.updatedAt = updatedAt
  }
  
  enum CodingKeys: String, CodingKey {
    case id
    case checklistId
    case content
    case isCompleted = "isCompleted"
    case createdAt
    case updatedAt
  }
  
  public static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.id == rhs.id
  }
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

extension CheckBox {
  static let mock1 = Self(
    id: 1,
    checklistId: 1,
    content: "협업 도구 활용",
    isCompleted: false,
    createdAt: "",
    updatedAt: ""
  )
  
  static let mock2 = Self(
    id: 2,
    checklistId: 1,
    content: "포넌트 요소화 등록",
    isCompleted: false,
    createdAt: "",
    updatedAt: ""
  )
  
  static let mock3 = Self(
    id: 3,
    checklistId: 1,
    content: "교육과 문서화",
    isCompleted: false,
    createdAt: "",
    updatedAt: ""
  )
  
  static let mock4 = Self(
    id: 4,
    checklistId: 1,
    content: "체크리스트를 생성해보세요",
    isCompleted: false,
    createdAt: "",
    updatedAt: ""
  )
  
  static let mock5 = Self(
    id: 5,
    checklistId: 1,
    content: "체크리스트를 생성해보세요5",
    isCompleted: false,
    createdAt: "",
    updatedAt: ""
  )
  
  static let mock6 = Self(
    id: 6,
    checklistId: 1,
    content: "체크리스트를 생성해보세요6",
    isCompleted: false,
    createdAt: "",
    updatedAt: ""
  )
  
  static let mock7 = Self(
    id: 7,
    checklistId: 1,
    content: "체크리스트를 생성해보세요7",
    isCompleted: false,
    createdAt: "",
    updatedAt: ""
  )
  
  static let mock8 = Self(
    id: 8,
    checklistId: 1,
    content: "체크리스트를 생성해보세요8",
    isCompleted: false,
    createdAt: "",
    updatedAt: ""
  )
}
