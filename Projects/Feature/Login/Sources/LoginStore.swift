//
//  LoginStore.swift
//  FeatureLogin
//
//  Created by 현수빈 on 1/8/25.
//

import Foundation

import CoreCommon
import CoreDomain
import CoreNetwork

import ComposableArchitecture
import KakaoSDKUser

@Reducer
public struct LoginStore {
  public init() { }
  
  public struct State {
    var isLoading: Bool = false
    public init() { }
  }
  
  public enum Action {
    case didTapKakaoLogin
    case didTapAppleLogin
    case didTapGuestLogin
    
    case routeToOnboardingScreen
  }
  

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .didTapGuestLogin:
        return .send(.routeToOnboardingScreen)
      case .routeToOnboardingScreen:
        return .none
        
      case .didTapKakaoLogin:
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")

                    //do something
                    _ = oauthToken
                }
            }
        }
        return .none
        
      default:
        return .none
      }
    }
  }
}
