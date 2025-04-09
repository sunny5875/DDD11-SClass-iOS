//
//  HistoryDetailStore.swift
//  FeatureHistory
//
//  Created by 현수빈 on 11/25/24.
//

import Foundation

import CoreDomain

import ComposableArchitecture

@Reducer
public struct HistoryDetailStore {
  public init() { }
  
  @ObservableState
  public struct State {
    var checkList: Checklist
    var article: [Article]
    var selected: CheckBox?
    var modal: ModalType? = .none
    var newTitle: String = ""
    var currentTab: TabItem = .checklist
    var isActive: Bool {
      newTitle != selected?.content
    }
    
    var isLoading = true
    public init(checklist: Checklist) {
      self.checkList = checklist
      self.article = []
      self.selected = nil
    }
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case onAppear
    
    case didTapChangeCurrentTab(TabItem)
    
    // MARK: - 체크박스 완료
    case didTapChecklistComplete(CheckBox)
    
    // MARK: - bottomsheet 처리
    case didTapDismiss
    
    // MARK: - 체크박스 삭제 처리
    case didTapDelete(CheckBox)
    case didTapDeleteConfirm
    case didTapDeleteCancel
    
    // MARK: - 체크박스 타이틀 변경 처리
    case didTapEditTitle(CheckBox)
    case didTapEditTitleConfirm
    case didTapEditTitleCancel
    
    // MARK: - Navigation
    case didTapBackButton
  }
  
  public enum ModalType: Identifiable {
    public var id: Self { return self }
    case delete
    case editTitle
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
        
      case .onAppear:
        return .none
        
      case .didTapChangeCurrentTab(let newTab):
          state.currentTab = newTab
        return .none
        
      case .didTapChecklistComplete(let checkBox):
        guard let index = state.checkList.checkBoxList
          .firstIndex(where: { $0 == checkBox })
        else {
          return .none
        }
        
        state.checkList.checkBoxList[index].isCompleted.toggle()
        return .none
        
      case .didTapEditTitle(let selected):
        state.selected = selected
        state.modal = .editTitle
        state.newTitle = state.selected?.content ?? ""
        return .none
        
      case .didTapDelete(let selected):
        state.selected = selected
        state.modal = .delete
        return .none
        
      case .didTapDeleteConfirm:
        if let selected = state.selected,
           let index = state.checkList.checkBoxList.firstIndex(of: selected) {
          state.checkList.checkBoxList.remove(at: index)
        }
        state.selected = nil
        return .none
        
      case .didTapDeleteCancel:
        state.modal = nil
        state.selected = nil
        return .none
        
      case .didTapEditTitleConfirm:
        state.modal = nil
        if let selected = state.selected,
           let index = state.checkList.checkBoxList.firstIndex(of: selected) {
          state.checkList.checkBoxList[index].content = state.newTitle
        }
        state.selected = nil
        return .none
        
      case .didTapEditTitleCancel:
        state.modal = nil
        state.selected = nil
        return .none
        
      case .didTapDismiss:
        state.modal = nil
        state.selected = nil
        return .none
        
      case .didTapBackButton:
        return .none
        
      }
    }
  }
}

public enum TabItem: CaseIterable {
  case checklist
  case article
  
  var title: String {
    switch self {
    case .checklist:
      return "체크리스트"
    case .article:
      return "아티클"
    }
  }
}
