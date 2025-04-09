//
//  CreateChecklistStore.swift
//  FeatureChat
//
//  Created by 현수빈 on 8/28/24.
//

import Foundation

import CoreDomain

import ComposableArchitecture
import CoreNetwork

@Reducer
public struct CreateChecklistStore {
  public init() { }
  
  @ObservableState
  public struct State {
    var checklist: Checklist
    var selectedChecklist: [CheckBox] = []
    
    public init(checklistID: Int) {
      self.checklist = .init(id: checklistID)
    }
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case onAppear
    case onCompleteGetChecklist(TaskResult<Checklist>)
    
    case didTapReCreateButton
    case didTapChecklist(CheckBox)
    
    case didTapSaveButton
    case onCompleteSaveButton([CheckBox])
    case pushEnterKeyword(Checklist)
    
    // navigation
    case didTapBackButton
    case pop
  }
  
  @Dependency(ChecklistAPIClient.self) var checklistAPIClient
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
        
      case .onAppear:
        let checklistID = state.checklist.id
        return .run { send in
          do {
            let checklist = try await checklistAPIClient.getChecklist(checklistID)
            await send(.onCompleteGetChecklist(.success(checklist)))
          } catch {
            await send(.onCompleteGetChecklist(.failure(error)))
          }
        }
      case .onCompleteGetChecklist(.success(let list)):
        state.checklist = list
        state.selectedChecklist = list.checkBoxList
        return .none
      case .onCompleteGetChecklist(.failure):
        return .none
      case .didTapChecklist(let selected):
        if let index = state.selectedChecklist.firstIndex(of: selected) {
          state.selectedChecklist.remove(at: index)
        } else {
          state.selectedChecklist.append(selected)
        }
        return .none
      case .didTapSaveButton:
        // TODO: api 연결
        return .none
//        let checklistId = state.checklist.id
//        let deleteCheckBoxList = state.checklist.checkBoxList.filter { !state.selectedChecklist.contains($0)
//        }.map { $0.id }
//        let selectCheckBoxList = state.selectedChecklist
//        return .run { send in
//          do {
//            _ = try await checklistAPIClient.deleteChecklist(
//              checklistId: checklistId,
//              checkBoxId: deleteCheckBoxList
//            )
//            await send(.onCompleteSaveButton(selectCheckBoxList))
//          } catch {
//            print(error.localizedDescription)
//          }
//        }
      case .onCompleteSaveButton(let list):
        state.checklist.checkBoxList = list
        return .send(.pushEnterKeyword(state.checklist))
        
      case .didTapBackButton:
        return .send(.pop)
      default:
        return .none
      }
    }
  }
}
