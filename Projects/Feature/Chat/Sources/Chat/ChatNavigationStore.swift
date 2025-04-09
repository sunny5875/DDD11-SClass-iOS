//
//  ChatNavigationStore.swift
//  FeatureChat
//
//  Created by 현수빈 on 8/31/24.
//

import Foundation

import CoreDomain
import SharedDesignSystem

import ComposableArchitecture

public extension ChatNavigationStore {
  @Reducer
  public enum ChatPath {
    case createChecklist(CreateChecklistStore)
    case enterKeyword(EnterKeywordStore)
  }
}

@Reducer
public struct ChatNavigationStore {
  public init() { }
  
  @ObservableState
  public struct State {
    var path = StackState<ChatPath.State>()
    public var chat: ChatStore.State = .init()
    public var checklist: CreateChecklistStore.State = .init(checklistID: 0)
    public var enterKeyword: EnterKeywordStore.State = .init(checklist: .init(id: 0))
    public init() {
    }
  }
  
  public enum Action {
    case path(StackActionOf<ChatPath>)
    case initializeChat
    
    case chat(ChatStore.Action)
    case checklist(CreateChecklistStore.Action)
    case enterKeyword(EnterKeywordStore.Action)
    
    case pop
  }
  
  public var body: some ReducerOf<Self> {
    
    Scope(state: \.chat, action: \.chat) {
      ChatStore()
    }
    
    Scope(state: \.checklist, action: \.checklist) {
      CreateChecklistStore()
    }
    
    Scope(state: \.enterKeyword, action: \.enterKeyword) {
      EnterKeywordStore()
    }
    
    Reduce { state, action in
      switch action {
      case .initializeChat:
        state.chat = ChatStore.State()
        return .none
      case .path(_):
        return .none
        
      case .pop:
        state.path.removeLast()
        return .none
        
      case .chat(.onCloseView):
        state.chat = ChatStore.State()
        return .none
        
      case .chat(.onCompleteCreateChecklist(let id)):
        state.checklist = CreateChecklistStore.State(checklistID: id)
        state.path.append(.createChecklist(state.checklist))
        return .none
        
      case .checklist(.pushEnterKeyword(let checklist)):
        state.enterKeyword = .init(checklist: checklist)
        state.path.append(.enterKeyword(state.enterKeyword))
        return .none
        
      case .checklist(.pop):
        state.path.removeLast()
        return .none
        
      case .enterKeyword(.pop):
        state.path.removeLast()
        return .none
        
      case .chat(_):
        return .none
        
      case .checklist(_):
        return .none
        
      case .enterKeyword(_):
        return .none
      }
    }
    .forEach(\.path, action: \.path)
  }
}

