//
//  UserInfo.swift
//  CoreDomain
//
//  Created by 홍은표 on 9/5/24.
//

import Foundation

public struct UserInfo: Equatable {
  public let userID: String
  public let nickName: String
  public let job: JobType
  public let workExperience: Int
  
  public init(
    userID: String,
    nickName: String,
    job: JobType,
    workExperience: Int
  ) {
    self.userID = userID
    self.nickName = nickName
    self.job = job
    self.workExperience = workExperience
  }
}

public extension UserInfo {
  static let mock = Self(
    userID: "mockId",
    nickName: "SClass",
    job: .developer,
    workExperience: 3
  )
}
