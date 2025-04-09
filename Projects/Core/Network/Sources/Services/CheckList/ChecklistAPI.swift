//
//  ChecklistAPI.swift
//  CoreNetwork
//
//  Created by 현수빈 on 9/8/24.
//

import Foundation

import CoreDomain

import Moya

enum ChecklistAPI {
  /// 목록 조회
  case getChecklists(userID: String)
  /// 상세 조회
  case getChecklist(id: Int)
  /// 체크리스트 프로젝트 삭제
  case deleteProject(checklistId: Int)
  /// 체크리스트 다중 항목 삭제
  case deleteChecklist(checklistId: Int, checkBoxId: Int)
  /// 체크리스트 프로젝트 제목 변경
  case changeKeyword(checklistId: Int, newKeyword: String)
  /// 완료 상태 변경
  case complete(checklistId: Int, id: Int, completed: Int)
}

extension ChecklistAPI: BaseAPI {
  var domain: OnboardingKitDomain {
    return .checklist
  }
  
  var method: Moya.Method {
    switch self {
    case .getChecklists:
      return .get
    case .getChecklist:
      return .get
    case .deleteProject:
      return .delete
    case .deleteChecklist:
      return .delete
    case .changeKeyword:
      return .put
    case .complete:
      return .patch
    }
  }
  
  var urlPath: String {
    switch self {
    case .getChecklists:
      return ""
      
    case .getChecklist(let id):
      return "/\(id)/items"
      
    case .deleteProject(let checklistId):
      return "/\(checklistId)"
    
    case .deleteChecklist(let checklistId, let id):
      return "/\(checklistId)/items/\(id)"
    
    case .changeKeyword(let checklistId, _):
      return "/\(checklistId)/title"
    
    case .complete(let checklistId, let id, _):
      return "/\(checklistId)/items/\(id)/complete"
    }
  }
  
  var parameters: [String: Any]? {
    switch self {
    case .getChecklists(let userID):
      return [:
        // "userNo": userID TODO: userNo받도록 서버 수정 필요
      ]
      
    case .getChecklist:
      return nil
      
    case .deleteProject(let checklistId):
      return [
        "checklistId": checklistId
      ]
      
    case .deleteChecklist(_, let list):
      return [
        "checkboxIds": list
      ]
      
    case .changeKeyword(_, let keyword):
      return [
        "title": keyword
      ]
      
    case .complete(let checklistId, let id, let completed):
      return [
        "checklistId": checklistId,
        "id": id,
        "completed": completed
      ]
    }
  }

  var error: [Int: NetworkError]? {
    return nil
  }
}
