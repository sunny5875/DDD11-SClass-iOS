//
//  Extension+TargetDependencySPM.swift
//  DependencyPackagePlugin
//
//  Created by 홍은표 on 6/23/24.
//

import ProjectDescription

public extension TargetDependency.SPM {
  static let composableArchitecture: TargetDependency = .external(
    name: "ComposableArchitecture",
    condition: .none
  )
    
  static let moya: TargetDependency = .external(
    name: "Moya",
    condition: .none
  )
  
  static let combineMoya: TargetDependency = .external(
    name: "CombineMoya",
    condition: .none
  )
  
  static let keychainAccess: TargetDependency = .external(
    name: "KeychainAccess",
    condition: .none
  )
  
  static let kingfisher: TargetDependency = .external(
    name: "Kingfisher",
    condition: .none
  )
  
  static let skeletonUI: TargetDependency = .external(
    name: "SkeletonUI",
    condition: .none
  )
  
  static let kakaoSDKUser: TargetDependency = .external(
    name: "KakaoSDKUser",
    condition: .none
  )
  
  static let kakaoSDKAuth: TargetDependency = .external(
    name: "KakaoSDKAuth",
    condition: .none
  )
}
