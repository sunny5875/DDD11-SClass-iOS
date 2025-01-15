//
//  SocialLoginInfo.swift
//  CoreDomain
//
//  Created by 현수빈 on 1/15/25.
//

import Foundation

public struct SocialLoginInfo: Equatable {
  public let idToken: String
  public let nonce: String?
  public let provider: Socialtype
  
  public init(
    idToken: String,
    nonce: String? = nil,
    provider: Socialtype
  ) {
    self.idToken = idToken
    self.nonce = nonce
    self.provider = provider
  }
}

extension SocialLoginInfo {
  public enum Socialtype: String {
    case kakao = "Kakao"
    case apple = "Apple"
  }
}
