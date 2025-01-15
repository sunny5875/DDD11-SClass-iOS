//
//  RootStore.swift
//  OnboardingKit
//
//  Created by 홍은표 on 7/27/24.
//

import Foundation

import Feature

import ComposableArchitecture

@Reducer
public struct RootStore {
  @ObservableState
  public enum State {
    case splash(SplashStore.State)
    case login(LoginStore.State)
    case onboarding(OnboardingRootStore.State)
    case mainTab(MainTabStore.State)
    
    init() {
      self = .splash(SplashStore.State())
    }
  }
  
  
  @Dependency(\.socialLogin) private var socialLogin
  
  public enum Action {
    case splash(SplashStore.Action)
    case login(LoginStore.Action)
    case onboarding(OnboardingRootStore.Action)
    case mainTab(MainTabStore.Action)
    case onOpenURL(URL)
  }
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .splash(.routeToLoginScreen):
        state = .login(LoginStore.State())
        return .none
      case .splash(.routeToMainTabScreen):
        state = .mainTab(MainTabStore.State(.home))
        return .none
      case .splash(.routeToOnboardingScreen), .login(.routeToOnboardingScreen):
        state = .onboarding(OnboardingRootStore.State())
        return .none
      case .onboarding(.onSuccessSignUp):
        state = .mainTab(MainTabStore.State(.home))
        return .none
      case .mainTab:
        return .none
          
      case let .onOpenURL(url):
        socialLogin.handleKakaoUrl(url)
        return .none
          
      default:
        return .none
      }
    }
    .ifCaseLet(\.splash, action: \.splash) {
      SplashStore()
    }
    .ifCaseLet(\.login, action: \.login) {
      LoginStore()
    }
    .ifCaseLet(\.onboarding, action: \.onboarding) {
      OnboardingRootStore()
    }
    .ifCaseLet(\.mainTab, action: \.mainTab) {
      MainTabStore()
    }
  }
}
