//
//  InfoPlistValues.swift
//  ProjectTemplatePlugin
//
//  Created by 홍은표 on 6/23/24.
//

import Foundation
import ProjectDescription

extension InfoPlist {
  public static let appInfoPlist: Self = .extendingDefault(
    with: InfoPlistDictionary()
      .setAppTransportSecurity(arbitaryLoad: true)
      .setUIUserInterfaceStyle("Light")
      .setAppIdentifierPrefix("$(AppIdentifierPrefix)")
      .setCFBundleDevelopmentRegion("$(DEVELOPMENT_LANGUAGE)")
      .setCFBundleExecutable("$(EXECUTABLE_NAME)")
      .setCFBundleIdentifier("$(PRODUCT_BUNDLE_IDENTIFIER)")
      .setCFBundleInfoDictionaryVersion("6.0")
      .setCFBundleName("$(PRODUCT_NAME)")
      .setCFBundlePackageType("APPL")
      .setCFBundleShortVersionString(Project.Environment.appVersion)
      .setCFBundleVersion(Project.Environment.appVersion)
      .setLSRequiresIPhoneOS(true)
      .setUIApplicationSceneManifest([
        "UIApplicationSupportsMultipleScenes": true,
        "UISceneConfigurations": [
          "UIWindowSceneSessionRoleApplication": [
            [
              "UISceneConfigurationName": "Default Configuration"
            ]
          ]
        ]
      ])
      .setUILaunchStoryboardName("LaunchScreen.storyboard")
      .setUIRequiredDeviceCapabilities(["armv7"])
      .setUISupportedInterfaceOrientations(["UIInterfaceOrientationPortrait"])
      .setCustomValue("baseURL", "$(BASE_URL)")
      .setCustomValue("chatBaseURL", "$(CHAT_BASE_URL)")
      .setCustomValue("KAKAO_NATIVE_APP_KEY", "$(KAKAO_NATIVE_APP_KEY)")
      .setCFBundleURLTypes("kakao$(KAKAO_NATIVE_APP_KEY)")
      .setLSApplicationQueriesSchemes() // kakao
    
  )
  
  public static let networkInfoPlist: Self = .extendingDefault(
    with: InfoPlistDictionary()
      .setCustomValue("baseURL", "$(BASE_URL)")
      .setCustomValue("chatBaseURL", "$(CHAT_BASE_URL)")
  )
}
