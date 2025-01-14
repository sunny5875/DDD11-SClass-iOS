//
//  LoginView.swift
//  OnboardingKit.
//
//  Created by OnboardingKit on 2025/01/08
//  Copyright © 2025 DDD , Ltd., All rights reserved.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct LoginView: View {
  
  @Bindable var store: StoreOf<LoginStore>
  
  public init(store: StoreOf<LoginStore>) {
    self.store = store
  }
  
  public var body: some View {
    VStack {
      header
      Spacer()
      loginButtons
    }
  }
  
  private var header: some View {
    HStack {
      VStack(alignment: .leading, spacing: 24) {
        Image.onboardingLogo
          .resizable()
          .scaledToFit()
          .frame(width: 62, height: 62)
        
        Text("사회초년생을 위한\n신입 업무키트")
          .notoSans(.display_2)
          .foregroundStyle(.greyScale950)
          .multilineTextAlignment(.leading)
      }
      Spacer()
    }
    .padding(.horizontal, 29)
    .padding(.top, 120)
  }
  
  private var loginButtons: some View {
    VStack(spacing: 16) {
      VStack(spacing: 12) {
        Button(action: {
          store.send(.didTapKakaoLogin)
        }) {
          Image.kakaoLogin
        }
        
        Button(action: {
          store.send(.didTapAppleLogin)
        }) {
          Image.appleLogin
        }
      }
      Button(action: {
        store.send(.didTapGuestLogin)
      }) {
        Text("게스트로 로그인")
          .notoSans(.subhead_2)
          .tint(Color.primary600)
      }
    }
  }
}
