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

struct LoginView: View {
  
//  @Bindable var store: StoreOf<LoginStore>
  
  var body: some View {
    VStack {
      header
      Spacer()
      loginButtons
    }
  }
  
  private var header: some View {
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
  }
  
  private var loginButtons: some View {
    VStack(spacing: 16) {
      VStack(spacing: 12) {
//        Button(action: {
//          
//        }) {
//          Image.kakaoLogin
//        }
        
//        Button(action: {
//            
//        }) {
//          Image.appleLogin
//        }
      }
      Button(action: {
        // TODO: - 액션 추가
      }) {
        Text("게스트로 로그인")
          .notoSans(.subhead_2)
          .underline(color: .primary600)
      }
    }
  }
}
