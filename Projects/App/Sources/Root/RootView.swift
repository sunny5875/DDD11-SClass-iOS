//
//  RootView.swift
//  OnboardingKit
//
//  Created by 홍은표 on 7/27/24.
//

import SwiftUI

import Feature

import ComposableArchitecture

struct RootView: View {
  @Bindable var store: StoreOf<RootStore>
  
  var body: some View {
    SwitchStore(self.store) { state in
      switch state {
      case .splash:
        if let store = store.scope(state: \.splash, action: \.splash) {
          SplashView(store: store)
        }
      case .login:
          if let store = store.scope(state: \.login, action: \.login) {
            LoginView(store: store)
          }
      case .onboarding:
        if let store = store.scope(state: \.onboarding, action: \.onboarding) {
          OnboardingRootView(store: store)
        }
      case .mainTab:
        if let store = store.scope(state: \.mainTab, action: \.mainTab) {
          MainTabView(store: store)
        }
      }
    }
    .onOpenURL { url in
      store.send(.onOpenURL(url))
    }
  }
}
