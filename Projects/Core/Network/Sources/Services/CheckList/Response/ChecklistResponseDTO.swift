//
//  ChecklistDTO.swift
//  CoreNetwork
//
//  Created by 현수빈 on 9/8/24.
//

import Foundation

import CoreDomain

public struct ChecklistResponseDTO: Decodable {
  let checklistId: Int
  let userNo: Int
  let title: String?
  let createdTime: String
  
  enum CodingKeys: String, CodingKey {
    case checklistId = "id"
    case userNo
    case title
    case createdTime
  }
}

extension ChecklistResponseDTO {
  var toEntity: Checklist {
    .init(
      id: self.checklistId,
      createdTime: self.createdTime,
      title: self.title,
      checkBoxList: []
    )
  }
}
