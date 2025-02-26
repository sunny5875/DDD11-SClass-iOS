//
//  RootApp.swift
//  OnboardingKit
//
//  Created by 홍은표 on 7/20/24.
//

import SwiftUI
import SharedDesignSystem
import ComposableArchitecture

@main
struct RootApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
  
  init() {
    SharedDesignSystemFontFamily.registerAllCustomFonts()
  }
  
  var body: some Scene {
    WindowGroup {
      RootView(
        store: .init(
          initialState: RootStore.State(),
          reducer: {
            RootStore()
              ._printChanges()
          }
        )
      )
    }
  }
}
