//
//  HistoryDetailView.swift
//  FeatureHistory
//
//  Created by 현수빈 on 11/25/24.
//

import SwiftUI

import CoreCommon
import CoreDomain
import SharedDesignSystem

import ComposableArchitecture

struct HistoryDetailView: View {
  @Bindable var store: StoreOf<HistoryDetailStore>
  
  @Namespace private var namespace
  
  init(store: StoreOf<HistoryDetailStore>) {
    self.store = store
  }
  
  var body: some View {
    VStack(spacing: 0) {
      TopNavigation(
        leadingItem: (Image.left, {
          store.send(.didTapBackButton)
        }),
        centerTitle: store.checkList.title ?? "-"
      )
      
      tabBar
      Group {
        switch store.currentTab {
        case .checklist:
          checklistContent
        case .article:
          articeContent
        }
      }
      .padding(.top, 24)
      .background(Color(hex: "#FAFAFA"))
      
    }
    .frame(maxWidth: .infinity)
    .historyAlert(
      isPresented: .init(
        get: { store.modal == .delete },
        set: { store.modal = $0 ? .delete : nil }
      ),
      title: "체크리스트 삭제",
      description: "이 체크리스트를 삭제하면 복구할 수 없어요. 그래도 삭제하시겠나요?",
      cancelText: "취소",
      confirmText: "삭제",
      onCancel: {
        store.send(.didTapDeleteCancel)
      },
      onSubmit: {
        store.send(.didTapDeleteConfirm)
      }
    )
    .sheet(item: $store.modal) { modal in
      switch modal {
      case .editTitle:
        CheckBoxEditTitleBottomSheetView(store: store)
          .presentationDetents([.height(320)])
          .cornerRadius(20)
      case .delete:
        EmptyView()
      }
    }
  }
  
  
  private var tabBar: some View {
    HStack(spacing: 4) {
      ForEach(TabItem.allCases, id: \.self) { tabItem in
        Button(action: {
          store.send(.didTapChangeCurrentTab(tabItem), animation: .smooth)
        }) {
          HStack {
            Spacer()
            Text(tabItem.title)
              .foregroundStyle(
                store.currentTab == tabItem
                ? .primary600
                : .gray
              )
              .frame(height: 50)
              .frame(maxWidth: .infinity)
            Spacer()
          }
          .background(alignment: .bottom) {
            if store.currentTab == tabItem {
              Rectangle()
                .frame(height: 2)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.primary)
                .matchedGeometryEffect(id: "underline", in: namespace)
            }
          }
        }
      }
      .padding(.horizontal, 16)
    }
    .frame(maxWidth: .infinity)
    .underline(color: .gray)
  }
  
  private var checklistContent: some View {
    List {
      ForEach(store.checkList.checkBoxList) { checkBox in
        DetailColorChecklistCellView(
          title: checkBox.content,
          isSelected: checkBox.isCompleted,
          onToggle: {
            store.send(.didTapChecklistComplete(checkBox))
          },
          onEdit: {
            store.send(.didTapEditTitle(checkBox))
          },
          onDelete: {
            store.send(.didTapDelete(checkBox))
          }
        )
      }
    }
    .listStyle(.plain)
    .listRowSpacing(12)
  }
  
  private var articeContent: some View {
    GeometryReader { geometry in
      VStack {
        SkeletonArticleListView(width: geometry.size.width - 32)
      }
      .padding(16)
    }
  }
}
