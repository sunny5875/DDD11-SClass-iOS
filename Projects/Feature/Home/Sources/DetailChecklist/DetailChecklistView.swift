//
//  DetailChecklistView.swift
//  FeatureHome
//
//  Created by 홍은표 on 10/21/24.
//

import Foundation
import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

struct DetailChecklistView: View {
  @Bindable private var store: StoreOf<DetailChecklistStore>
  
  init(store: StoreOf<DetailChecklistStore>) {
    self.store = store
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: .zero) {
      TopNavigation(
        leadingItem: (
          Image.left,
          {
            store.send(.didTapBackButton)
          }
        ),
        centerTitle: store.card.title
      )
      
      VStack(alignment: .leading, spacing: 16) {
        VStack(alignment: .leading, spacing: 8) {
          Text("등록된 체크리스트")
            .notoSans(.subhead_3)
            .foregroundStyle(.greyScale950)
          
          Text("체크리스트를 옆으로 밀면 삭제를 할 수 있어요.")
            .notoSans(.caption)
            .foregroundStyle(.greyScale400)
        }
        .padding([.top, .horizontal], 12)
        
        List {
          ForEach(store.card.checkBoxList) { checkBox in
            DetailColorChecklistCellView(
              title: checkBox.content,
              isSelected: checkBox.isCompleted,
              onToggle: {
                store.send(.didTapChecklistCompleteButton(checkBox: checkBox))
              },
              onDelete: {
                store.send(.onSwipeToDeleteCheckBox(checkBox: checkBox))
              }
            )
          }
        }
        .listStyle(.plain)
        .listRowSpacing(12)
      }
    }
    .historyAlert(
      isPresented: $store.isPresentDeleteCheckBoxAlert,
      title: "체크리스트 삭제",
      description: store.card.checkBoxList.count == 1
      ? "해당 체크리스트를 삭제하면 연결된 업무 폴더도 함께 삭제돼요. 그래도 삭제하시겠나요?"
      : "이 체크리스트를 삭제하면 복구할 수 없어요.\n그래도 삭제하시겠나요?",
      cancelText: "취소",
      confirmText: "삭제",
      onCancel: {
        store.send(.didTapCancelSwipeToDeleteCheckBox)
      },
      onSubmit: {
        store.send(.didTapConfirmSwipeToDeleteCheckBox)
      }
    )
  }
}
