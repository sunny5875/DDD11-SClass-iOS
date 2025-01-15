//
//  SocialLoginClient.swift
//  CoreNetwork
//
//  Created by 현수빈 on 1/15/25.
//

import Foundation

import CoreDomain

import ComposableArchitecture

public struct SocialLoginClient {
  public var initKakaoSDK: @Sendable () -> Void
  public var handleKakaoUrl: @Sendable (URL) -> Void
  public var kakaoLogin: @Sendable () async throws -> SocialLoginInfo
  public var appleLogin: @Sendable () async throws -> SocialLoginInfo
}

extension SocialLoginClient: DependencyKey {
  public static var liveValue: SocialLoginClient {
    let kakaoLogin = KakaoLogin()
    let appleLogin = AppleLogin()
    
    return Self(
      initKakaoSDK: {
        kakaoLogin.initSDK()
      },
      handleKakaoUrl: {
        kakaoLogin.handleKakaoTalkLoginUrl(url: $0)
      },
      kakaoLogin: {
        try await kakaoLogin.kakaoLogin()
      },
      appleLogin: {
        try await appleLogin.appleLogin()
      }
    )
  }
}

public extension DependencyValues {
  var socialLogin: SocialLoginClient {
    get { self[SocialLoginClient.self] }
    set { self[SocialLoginClient.self] = newValue }
  }
}
