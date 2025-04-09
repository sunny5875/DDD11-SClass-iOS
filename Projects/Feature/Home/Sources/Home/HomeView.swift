//
//  HomeView.swift
//  FeatureHome
//
//  Created by 홍은표 on 9/13/24.
//

import Foundation
import SwiftUI

import CoreDomain
import SharedDesignSystem
import SharedUtils

import ComposableArchitecture

struct HomeView: View {
  @Bindable private var store: StoreOf<HomeStore>
  
  init(store: StoreOf<HomeStore>) {
    self.store = store
  }
  
  var body: some View {
    GeometryReader { geometry in
      backgroundView(size: geometry.size)
      
      ScrollView {
        VStack(alignment: .leading, spacing: 16) {
          HeaderView(store: store)
          content(size: geometry.size)
        }
      }
    }
    .onAppear {
      store.send(.onAppear)
    }
    .fullScreenCover(item: $store.selectedArticle) { article in
      HomeArticleWebView(
        store: store,
        article: article
      )
    }
  }
  
  private func backgroundView(size: CGSize) -> some View {
    Image.homeBackground
      .resizable()
      .scaledToFill()
      .frame(width: size.width, height: size.height)
  }
  
  @ViewBuilder
  private func content(size: CGSize) -> some View {
    VStack(spacing: .zero) {
      Spacer().frame(height: 14)
      
      if store.isLoading {
        SkeletonContentView(width: size.width)
      } else {
        VStack(spacing: 20) {
          if let selectedCard = store.selectedCard {
            checklistList(selectedCard: selectedCard)
          }
          
          articleList
        }
      }
    }
    .frame(width: size.width)
    .background(.greyScale0)
    .clipShape(
      .rect(
        topLeadingRadius: 20,
        bottomLeadingRadius: 0,
        bottomTrailingRadius: 0,
        topTrailingRadius: 20
      )
    )
  }
  
  @ViewBuilder
  private func checklistList(selectedCard: Card) -> some View {
    VStack(spacing: 16) {
      ListSection(
        title: selectedCard.title,
        onTap: {
          store.send(.didTapNavigateToDetailChecklist(card: selectedCard))
        }
      )
      
      Group {
        if store.displayedCheckBoxes.isEmpty {
          checklistCompleteView
        } else {
          ForEach(store.displayedCheckBoxes) { checkBox in
            DefaultColorChecklistCellView(
              title: checkBox.content,
              isSelected: checkBox.isCompleted,
              onToggle: {
                store.send(.didTapChecklistCompleteButton(checkBox: checkBox))
              }
            )
          }
        }
      }
      .padding(.horizontal, 16)
    }
  }
  
  private var checklistCompleteView: some View {
    HStack(spacing: .zero) {
      Text("체크리스트를 모두 완료했어요.")
        .multilineTextAlignment(.leading)
        .notoSans(.body_long_1)
        .foregroundStyle(.greyScale600)
        .padding(.leading, 20)
      Spacer()
    }
    .padding(.trailing, 15)
    .frame(maxWidth: .infinity)
    .frame(height: 48)
    .background(.primary100)
    .clipShape(RoundedRectangle(cornerRadius: 4))
    .shadow(color: .greyScale950.opacity(0.05), radius: 5, x: 0, y: 4)
  }
  
  private var articleList: some View {
    VStack(spacing: 16) {
      ListSection(
        title: "관련 아티클",
        onTap: {}
      )
      
      ForEach(store.articles) { article in
        ArticleCellView(
          thumbnail: { ThumbnailImage(urlString: article.thumbnailURL) },
          title: article.title,
          category: article.category,
          platform: article.platform,
          postDate: article.postDate.formatted(using: .shortForm),
          url: article.url,
          onTap: {
            store.send(.didTapArticle(article))
          }
        )
      }
    }
  }
}
