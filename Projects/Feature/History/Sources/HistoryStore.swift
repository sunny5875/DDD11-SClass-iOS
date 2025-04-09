//
//  HistoryStore.swift
//  FeatureHistory
//
//  Created by 현수빈 on 11/12/24.
//

import Foundation
import ComposableArchitecture

import CoreDomain

@Reducer
public struct HistoryStore {
  public init() { }
  
  @ObservableState
  public struct State {
    var checkList: [Checklist] = []
    var selected: Checklist? = .none
    var modal: ModalType? = .none
    var newTitle: String = ""
    var isActive: Bool {
      3...8 ~= newTitle.count
    }
    
    var path = StackState<Path.State>()
    var historyDetail: HistoryDetailStore.State = .init(checklist: .mock1)
    public init() {}
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case path(StackActionOf<Path>)
    case onAppear
    
    case didTapChecklistMenu(Checklist)
    case didTapChecklist(Checklist)
    
    // bottomsheet 처리
    case didTapDismiss
    case didTapDelete
    case didTapEditTitle
    
    // alert 처리
    case didTapDeleteConfirm
    case didTapDeleteCancel
    
    // 제목변경 처리
    case didTapEditTitleConfirm
    case didTapEditTitleCancel
    
    
    case historyDetail(HistoryDetailStore.Action)
  }
  
  @Reducer
  public enum Path {
    case historyDetail(HistoryDetailStore)
  }
  
  public enum ModalType: Identifiable {
    public var id: Self { return self }
    case menu
    case delete
    case editTitle
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    
    Scope(state: \.historyDetail, action: \.historyDetail) {
      HistoryDetailStore()
    }
    
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
        
      case .onAppear:
        state.checkList = [
          .mock1,
          .mock2
        ]
        return .none
        
      case .didTapChecklist(let selected):
        state.historyDetail = .init(checklist: selected)
        state.path.append(.historyDetail(.init(checklist: selected)))
        return .none
        
      case .didTapChecklistMenu(let selected):
        state.selected = selected
        state.modal = .menu
        return .none
        
      case .didTapEditTitle:
        state.modal = .editTitle
        state.newTitle = state.selected?.title ?? ""
        return .none
        
      case .didTapDelete:
        state.modal = .delete
        return .none
        
      case .didTapDeleteConfirm:
        if let selected = state.selected,
           let index = state.checkList.firstIndex(of: selected) {
          state.checkList.remove(at: index)
        }
        state.selected = nil
        return .none
        
      case .didTapEditTitleConfirm:
        state.modal = nil
        if let selected = state.selected,
           let index = state.checkList.firstIndex(of: selected) {
          state.checkList[index].title = state.newTitle
        }
        state.selected = nil
        return .none
        
      case .didTapDismiss, .didTapDeleteCancel, .didTapEditTitleCancel:
        state.modal = nil
        state.selected = nil
        return .none
        
      case let .path(action):
        switch action {
        case .element(id: _, action: .historyDetail(.didTapBackButton)):
          state.path.removeLast()
          return .none
          
        default:
          return .none
        }
        
      default:
        return .none
      }
    }.forEach(\.path, action: \.path)
  }
}
