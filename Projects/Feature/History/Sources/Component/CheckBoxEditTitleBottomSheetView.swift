//
//  CheckBoxEditTitleBottomSheetView.swift
//  FeatureHistory
//
//  Created by 현수빈 on 11/26/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

struct CheckBoxEditTitleBottomSheetView: View {
  @Bindable var store: StoreOf<HistoryDetailStore>
  @FocusState var focus: Bool
  var body: some View {
    VStack(spacing: 13) {
      TopNavigation(
        centerTitle: "",
        trailingItem: (Image.closeCross, {
          store.send(.didTapDismiss)
        })
      )
      HStack {
        Text("내용 변경")
          .notoSans(.headline)
          .foregroundStyle(Color.greyScale950)
        Spacer()
      }
      .padding(.horizontal, 20)
      .padding(.vertical, 12)
      
      
      InputField(
        errorMessage: .constant(nil),
        text: $store.newTitle,
        placeHolder: store.selected?.content ?? "내용 변경",
        isFocused: $focus
      )
      
      
      VStack(spacing: 10) {
        CommonButton(
          title: "수정완료",
          style: .default,
          isActive: store.isActive,
          action: { store.send(.didTapEditTitleConfirm) }
        )
        CommonButton(
          title: "취소",
          style: .line,
          isActive: true,
          action: { store.send(.didTapEditTitleCancel) }
        )
      }
    }
    .padding(.horizontal, 16)
    .onAppear {
      focus = true
    }
  }
  
}
