//
//  Images.swift
//  SharedDesignSystem
//
//  Created by 홍은표 on 8/15/24.
//

import SwiftUI

fileprivate typealias ImageAsset = SharedDesignSystemAsset.Image

public extension Image {
  static let home: Self = ImageAsset.home.swiftUIImage
  static let article: Self = ImageAsset.article.swiftUIImage
  static let chat: Self = ImageAsset.chat.swiftUIImage
  static let history: Self = ImageAsset.history.swiftUIImage
  static let myPage: Self = ImageAsset.myPage.swiftUIImage
  
  static let rotateLeft: Self = ImageAsset.rotateLeft.swiftUIImage
  static let closeCross: Self = ImageAsset.closeCross.swiftUIImage
  static let externalLink: Self = ImageAsset.externalLink.swiftUIImage
  static let lock: Self = ImageAsset.lock.swiftUIImage
  static let articleEmptyView: Self = ImageAsset.articleEmptyView.swiftUIImage
  static let historyEmptyView: Self = ImageAsset.historyEmptyView.swiftUIImage
  static let `right`: Self = ImageAsset.right.swiftUIImage
  static let check: Self = ImageAsset.check.swiftUIImage
  
  static let sendDeactive: Self = ImageAsset.sendDeactive.swiftUIImage
  static let sendActive: Self = ImageAsset.sendActive.swiftUIImage
  static let chatbot: Self = ImageAsset.chatbot.swiftUIImage
  
  static let onboardingLogo: Self = ImageAsset.onboardingLogo.swiftUIImage
  static let `left`: Self = ImageAsset.left.swiftUIImage
  static let onboardingAISettingComplete: Self = ImageAsset.onboardingAISettingComplete.swiftUIImage
  static let chatPlaceholder: Self = ImageAsset.chatPlaceholder.swiftUIImage
  
  static let homeBackground: Self = ImageAsset.homeBackground.swiftUIImage
  static let plus: Self = ImageAsset.plus.swiftUIImage
  static let appendFolder: Self = ImageAsset.appendFolder.swiftUIImage
    
  static let vertical: Self = ImageAsset.vertical.swiftUIImage
  static let horizontal: Self = ImageAsset.horizontal.swiftUIImage
  
  static let trash: Self = ImageAsset.trash.swiftUIImage
	static let pencil: Self = ImageAsset.pencil.swiftUIImage
  
  
  static let kakaoLogin: Self = ImageAsset.kakaoLogin.swiftUIImage
  static let appleLogin: Self = ImageAsset.appleLogin.swiftUIImage
}
