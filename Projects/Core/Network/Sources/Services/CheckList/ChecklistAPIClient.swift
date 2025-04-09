//
//  ChecklistAPIClient.swift
//  CoreNetwork
//
//  Created by 현수빈 on 9/8/24.
//

import Foundation

import CoreDomain

import Combine
import CombineMoya
import ComposableArchitecture
import Moya

@DependencyClient
public struct ChecklistAPIClient: Sendable {
  public var getChecklists: @Sendable(_ userID: String) async throws -> [Checklist]
  public var getChecklist: @Sendable(_ id: Int) async throws -> Checklist
  public var deleteProject: @Sendable(_ checklistId: Int) async throws -> Void
  public var deleteChecklist: @Sendable(_ checklistId: Int, _ checkBoxId: Int) async throws -> [String]
  public var changeKeyword: @Sendable(_ checklistId: Int, _ newKeyword: String) async throws -> Void
  public var complete: @Sendable(_ checklistId: Int, _ id: Int, _ completed: Bool) async throws -> Void
}

public extension DependencyValues {
  var checklistAPIClient: ChecklistAPIClient {
    get { self[ChecklistAPIClient.self] }
    set { self[ChecklistAPIClient.self] = newValue }
  }
}

extension ChecklistAPIClient: DependencyKey {
  public static var liveValue: ChecklistAPIClient = .init(
    getChecklists: { userID in
      let api = ChecklistAPI.getChecklists(userID: userID)
      let responseDTO: ChecklistsResponseDTO = try await APIService<ChecklistAPI>().request(api: api)
      return responseDTO.checklists.map { $0.toEntity }
    },
    getChecklist: { id in
      let api = ChecklistAPI.getChecklist(id: id)
      let responseDTO: ChecklistResponseDTO = try await APIService<ChecklistAPI>().request(api: api)
      return responseDTO.toEntity
    },
    deleteProject: { checklistId in
      let api = ChecklistAPI.deleteProject(checklistId: checklistId)
      let responseDTO: EmptyResponseDTO = try await APIService<ChecklistAPI>().request(api: api)
    },
    deleteChecklist: { checklistId, checkBox in
      let api = ChecklistAPI.deleteChecklist(checklistId: checklistId, checkBoxId: checkBox)
      let responseDTO: DeleteChecklistResponseDTO = try await APIService<ChecklistAPI>().request(api: api)
      return responseDTO.deletedIds
    },
    changeKeyword: { checklistId, title in
      let api = ChecklistAPI.changeKeyword(checklistId: checklistId, newKeyword: title)
      let responseDTO: EmptyResponseDTO = try await APIService<ChecklistAPI>().request(api: api)
    },
    complete: { checklistId, id, completed in
      let api = ChecklistAPI.complete(checklistId: checklistId, id: id, completed: completed ? 1 : 0)
      let responseDTO: EmptyResponseDTO = try await APIService<ChecklistAPI>().request(api: api)
    }
  )
  
  public static var testValue: ChecklistAPIClient = Self()
}
