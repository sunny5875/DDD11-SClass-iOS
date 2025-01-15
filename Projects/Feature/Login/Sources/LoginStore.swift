//
//  LoginStore.swift
//  FeatureLogin
//
//  Created by 현수빈 on 1/8/25.
//

import AuthenticationServices
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
    var isLoading = false
    var isLoggedIn = false
    var user: UserInfo? = nil
    public init() { }
  }
  
  public enum Action {
    case didTapKakaoLogin
    case didTapAppleLogin
    case loginSuccess(UserInfo)
    case loginFailure
    case didTapGuestLogin
    case setLoading(Bool)
    
    case routeToOnboardingScreen
  }

  @Dependency(\.socialLogin) private var socialLogin
  
  public var body: some ReducerOf<Self> {
    Reduce { state,action in
      switch action {
      case .didTapGuestLogin:
        return .send(.routeToOnboardingScreen)
        
      case .routeToOnboardingScreen:
        return .none
        
      case .didTapKakaoLogin:
        if (UserApi.isKakaoTalkLoginAvailable()) {
          return .run(
            operation: { send in
              await send(.setLoading(true))
              
              let info = try await socialLogin.kakaoLogin()
              let user = UserInfo(
                userID: info.idToken,
                nickName: "",
                job: .developer,
                workExperience: 0
              )
              await send(.loginSuccess(user))
            },
            catch: { error, send in
              debugPrint(error)
              await send(.setLoading(false))
              await send(.loginFailure)
            }
          )
        } else {
          return .none
        }
      case let .loginSuccess(user):
        state.isLoggedIn = true
        state.user = user
        return .none
        
      case .loginFailure:
        return .none
        
      case .didTapAppleLogin:
        return .run(
          operation: { send in
            await send(.setLoading(true))
            let info = try await socialLogin.appleLogin()
            let user = UserInfo(
              userID: info.idToken,
              nickName: "",
              job: .developer,
              workExperience: 0
            )
            await send(.loginSuccess(user))
          },
          catch: { error, send in
            await send(.setLoading(false))
            
            guard let appleAuthError = error as? AppleErrorType else {
              await send(.loginFailure)
              return
            }
            
            if case .dismissASAuthorizationController = appleAuthError {
              return
            }
            
            await send(.loginFailure)
          }
        )
        
      default:
        return .none
      }
    }
  }
}

