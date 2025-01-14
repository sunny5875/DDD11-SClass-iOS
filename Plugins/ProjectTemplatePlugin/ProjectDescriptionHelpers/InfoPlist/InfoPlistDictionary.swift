//
//  InfoPlistDictionary.swift
//  ProjectTemplatePlugin
//
//  Created by 홍은표 on 7/12/24.
//

import Foundation
import ProjectDescription

public typealias InfoPlistDictionary = [String: Plist.Value]

public extension InfoPlistDictionary {
  func setAppIdentifierPrefix(_ value: String) -> InfoPlistDictionary {
    return self.merging(["AppIdentifierPrefix": .string(value)]) { (_, new) in new }
  }
  
  func setUIUserInterfaceStyle(_ value: String) -> InfoPlistDictionary {
    return self.merging(["UIUserInterfaceStyle": .string(value)]) { (_, new) in new }
  }
  
  func setCFBundleDevelopmentRegion(_ value: String) -> InfoPlistDictionary {
    return self.merging(["CFBundleDevelopmentRegion": .string(value)]) { (_, new) in new }
  }
  
  func setCFBundleExecutable(_ value: String) -> InfoPlistDictionary {
    return self.merging(["CFBundleExecutable": .string(value)]) { (_, new) in new }
  }
  
  func setCFBundleIdentifier(_ value: String) -> InfoPlistDictionary {
    return self.merging(["CFBundleIdentifier": .string(value)]) { (_, new) in new }
  }
  
  func setCFBundleInfoDictionaryVersion(_ value: String) -> InfoPlistDictionary {
    return self.merging(["CFBundleInfoDictionaryVersion": .string(value)]) { (_, new) in new }
  }
  
  func setCFBundleName(_ value: String) -> InfoPlistDictionary {
    return self.merging(["CFBundleName": .string(value)]) { (_, new) in new }
  }
  
  func setAppTransportSecurity(arbitaryLoad: Bool) -> [String: Plist.Value] {
       return [
           "NSAppTransportSecurity": .dictionary([
               "NSAllowsArbitraryLoads": .boolean(arbitaryLoad)
           ])
       ]
   }
  
  func setCFBundlePackageType(_ value: String) -> InfoPlistDictionary {
    return self.merging(["CFBundlePackageType": .string(value)]) { (_, new) in new }
  }
  
  func setCFBundleShortVersionString(_ value: String) -> InfoPlistDictionary {
    return self.merging(["CFBundleShortVersionString": .string(value)]) { (_, new) in new }
  }
  
  func setCFBundleVersion(_ value: String) -> InfoPlistDictionary {
    return self.merging(["CFBundleVersion": .string(value)]) { (_, new) in new }
  }
  
  func setLSRequiresIPhoneOS(_ value: Bool) -> InfoPlistDictionary {
    return self.merging(["LSRequiresIPhoneOS": .boolean(value)]) { (_, new) in new }
  }
  
  func setUIAppFonts(_ value: [String]) -> InfoPlistDictionary {
    return self.merging(["UIAppFonts": .array(value.map { .string($0) })]) { (_, new) in new }
  }
  
  func setUIApplicationSceneManifest(_ value: [String: Any]) -> InfoPlistDictionary {
    func convertToPlistValue(_ value: Any) -> Plist.Value {
      switch value {
      case let string as String:
        return .string(string)
      case let array as [Any]:
        return .array(array.map { convertToPlistValue($0) })
      case let dictionary as [String: Any]:
        return .dictionary(dictionary.mapValues { convertToPlistValue($0) })
      case let bool as Bool:
        return .boolean(bool)
      default:
        return .string("\(value)")
      }
    }
    return self.merging(["UIApplicationSceneManifest": convertToPlistValue(value)]) { (_, new) in new }
  }
  
  func setUILaunchStoryboardName(_ value: String) -> InfoPlistDictionary {
    return self.merging(["UILaunchStoryboardName": .string(value)]) { (_, new) in new }
  }
  
  func setUIRequiredDeviceCapabilities(_ value: [String]) -> InfoPlistDictionary {
    return self.merging(["UIRequiredDeviceCapabilities": .array(value.map { .string($0) })]) { (_, new) in new }
  }
  
  func setUISupportedInterfaceOrientations(_ value: [String]) -> InfoPlistDictionary {
    return self.merging(["UISupportedInterfaceOrientations": .array(value.map { .string($0) })]) { (_, new) in new }
  }
  
  func setLSApplicationQueriesSchemes(_ value: [String] = ["kakaokompassauth", "kakaolink"]) -> InfoPlistDictionary {
    return self.merging(["LSApplicationQueriesSchemes": .array(value.map { .string($0) })]) { (_, new) in new }
  }
  
  func setCFBundleURLTypes(_ value: String) -> InfoPlistDictionary {
    return self.merging(["CFBundleURLTypes": .array([.dictionary([
      "CFBundleTypeRole": .string("Editor"),
      "CFBundleURLSchemes": .array([.string(value)])
  ])])]) { (_, new) in new }
  }
  
  func setCustomValue(_ key: String, _ value: String) -> InfoPlistDictionary {
    return self.merging([key: .string(value)]) { (_, new) in new }
  }
}
