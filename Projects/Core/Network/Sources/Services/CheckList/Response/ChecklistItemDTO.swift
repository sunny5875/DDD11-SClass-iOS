////
////  ChecklistItemDTO.swift
////  CoreNetwork
////
////  Created by 현수빈 on 9/8/24.
////
//
//import Foundation
//
//import CoreDomain
//
//public struct ChecklistItemDTO: Decodable {
//  let checklistId: String
//  let label: String
//  let isCompleted: Int
//  let isMain: Int
//  let createdAt: String
//  let id: String
//  
//  public init(
//    checklistId: String,
//    label: String,
//    isCompleted: Int,
//    isMain: Int,
//    createdAt: String,
//    id: String
//  ) {
//    self.checklistId = checklistId
//    self.label = label
//    self.isCompleted = isCompleted
//    self.isMain = isMain
//    self.createdAt = createdAt
//    self.id = id
//  }
//}
//
//
//extension ChecklistItemDTO {
//  var toEntity: CheckBox {
//    .init(
//      checklistId: self.checklistId,
//      content: self.label,
//      isCompleted: self.isCompleted == 1,
//      isMain: self.isMain == 1,
//      createdAt: self.createdAt,
//      id: self.id
//    )
//  }
//}
