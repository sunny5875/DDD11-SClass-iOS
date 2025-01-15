//
//  TokenInfo.swift
//  CoreNetwork
//
//  Created by 현수빈 on 1/15/25.
//

import Foundation

public struct TokenInfo {
  public let accessToken: String
  public let refreshToken: String
  
  public init(accessToken: String, refreshToken: String) {
    self.accessToken = accessToken
    self.refreshToken = refreshToken
  }
}
