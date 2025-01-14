//
//  SplashStore.swift
//  FeatureSplash
//
//  Created by 홍은표 on 9/6/24.
//

import Foundation

import CoreCommon
import CoreDomain
import CoreNetwork

import ComposableArchitecture

@Reducer
public struct SplashStore {
  public init() { }
  
  @ObservableState
  public struct State {
    @Shared(.userInfo) var userInfo: UserInfo?
    
    public init() { }
  }
  
  public enum Action {
    case onAppear
    case routeToLoginScreen
    case routeToOnboardingScreen
    case routeToMainTabScreen
    case fetchUser(TaskResult<UserInfo>)
  }
  
  @Dependency(KeychainClient.self) var keychainClient
  @Dependency(MyPageAPIClient.self) var myPageAPIClient
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        return handleRouting()
      case .routeToLoginScreen:
        return .none
      case .routeToOnboardingScreen:
        return .none
      case .routeToMainTabScreen:
        return .none
      case .fetchUser(.success(let userInfo)):
        state.userInfo = userInfo
        return .send(.routeToMainTabScreen)
      case .fetchUser(.failure):
        return .send(.routeToLoginScreen)
      }
    }
  }
  
  private func handleRouting() -> Effect<Action> {
    if keychainClient.isSignIn {
      return requestFetchUser()
    } else {
      return .send(.routeToLoginScreen)
    }
  }
  
  private func requestFetchUser() -> Effect<Action> {
    guard let userID = keychainClient.userID else {
      return .send(.routeToLoginScreen)
    }
    
    return .run { [userID = userID] send in
      await send(.fetchUser(
        TaskResult {
          try await myPageAPIClient.fetchUser(userID: userID)
        }
      ))
    }
  }
}
