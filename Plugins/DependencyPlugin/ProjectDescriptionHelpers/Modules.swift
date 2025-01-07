//
//  Modules.swift
//  DependencyPlugin
//
//  Created by 현수빈 on 2024/07/06.
//

import Foundation
import ProjectDescription

public enum ModulePath {
  case feature(Feature)
  case core(Core)
  case shared(Shared)
}

// MARK: AppModule

public extension ModulePath {
  enum App: String, CaseIterable {
    case iOS = "iOS"
    case iPadOS = "iPadOS"
    
    public static let name: String = "App"
  }
}

// MARK: PresentationModule

public extension ModulePath {
  enum Feature: String, CaseIterable {
    case onboarding = "Onboarding"
    case home = "Home"
    case history = "History"
    case chat = "Chat"
    case article = "Article"
    case myPage = "MyPage"
    case splash = "Splash"
    case login = "Login"
    
    public static let name: String = "Feature"
  }
}

// MARK: CoreModule

public extension ModulePath {
  enum Core: String, CaseIterable {
    case common = "Common"
    case domain = "Domain"
    case network = "Network"
    
    public static let name: String = "Core"
  }
}

// MARK: SharedModule

public extension ModulePath {
  enum Shared: String, CaseIterable {
    case utils = "Utils"
    case thirdPartyLib = "ThirdPartyLib"
    case designSystem = "DesignSystem"
    
    public static let name: String = "Shared"
  }
}
