//
//  MyPageRootStore.swift
//  FeatureMyPage
//
//  Created by 홍은표 on 8/9/24.
//

import Foundation

import CoreCommon
import CoreDomain

import ComposableArchitecture

@Reducer
public struct MyPageRootStore {
  @ObservableState
  public struct State {
    var path: StackState<Path.State> = .init()
    var myPage: MyPageStore.State = .init()
    
    public init() {}
  }
  
  public enum Action: BindableAction {
    case binding(_ action: BindingAction<State>)
    case path(StackActionOf<Path>)
    case myPage(MyPageStore.Action)
  }
  
  @Reducer
  public enum Path {
    case legalDocument(LegalDocumentStore)
  }
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case let .path(action):
        return handlePathAction(state: &state, action: action)
      case .binding(_):
        return .none
      case .myPage(.navigateToLegalDocumentPage(let document)):
        state.path.append(.legalDocument(LegalDocumentStore.State(document: document)))
        return .none
      default:
        return .none
      }
    }
    .forEach(\.path, action: \.path)
    
    Scope(state: \.myPage, action: \.myPage) {
      MyPageStore()
    }
  }
  
  private func handlePathAction(state: inout State, action: StackActionOf<Path>) -> Effect<Action> {
    switch action {
    case .element(id: _, action: .legalDocument(.navigateToPreviousPage)):
      state.path.removeLast()
      return .none
    default:
      return .none
    }
  }
}
