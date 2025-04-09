//
//  CreateChecklistView.swift
//  FeatureChat
//
//  Created by 현수빈 on 8/28/24.
//

import SwiftUI

import CoreDomain

import ComposableArchitecture
import SharedDesignSystem

struct CreateChecklistView: View {
  @Bindable var store: StoreOf<CreateChecklistStore>
  
  var body: some View {
    VStack {
      TopNavigation(
        leadingItem: (Image.left, {
          store.send(.didTapBackButton)
        }),
        centerTitle: "체크리스트"
      )
      
      
      ScrollView {
        ForEach(store.checklist.checkBoxList, id: \.id) {
          CheckItem(store: store, item: $0)
        }
        ButtonSmall(title: "체크리스트 다시 생성하기", highLightTitle: "체크리스트", action: {
          store.send(.didTapBackButton)
        })
      }
      .padding(16)
      
      CommonButton(
        title: "저장하기",
        style: .default,
        isActive: true,
        action: {
          store.send(.didTapSaveButton)
        }
      )
      .padding(16)
    }
    .navigationBarBackButtonHidden()
    .onAppear {
      store.send(.onAppear)
    }
  }
}

private struct CheckItem: View {
  @Bindable var store: StoreOf<CreateChecklistStore>
  @State private var isSelected: Bool = true
  private let item: CheckBox
  
  init(store: StoreOf<CreateChecklistStore>, item: CheckBox) {
    self.store = store
    self.item = item
  }
  
  var body: some View {
    CreateChecklistCellView(
      isSelected: $isSelected,
      title: item.content
    ) {
      store.send(.didTapChecklist(item))
    }
  }
}
