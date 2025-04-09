//
//  HomeStore.swift
//  FeatureHome
//
//  Created by 홍은표 on 9/13/24.
//

import Foundation

import CoreCommon
import CoreDomain
import CoreNetwork

import ComposableArchitecture

@Reducer
public struct HomeStore {
  @ObservableState
  public struct State {
    @Shared(.userInfo) var userInfo: UserInfo?
    
    var isViewDidLoad: Bool = false
    var isLoading: Bool = true
    
    var cards: IdentifiedArrayOf<Card> = []
    var articles: IdentifiedArrayOf<Article> = []
    var displayedCheckBoxes: IdentifiedArrayOf<CheckBox> = []
    
    var selectedCard: Card?
    var selectedArticle: Article?
    
    public init() {}
  }
  
  public enum Action: BindableAction {
    
    // MARK: - Life Cycle
    
    case onAppear
    
    // MARK: - View
    
    case binding(BindingAction<State>)
    case detailChecklist(DetailChecklistStore.Action)
    
    // MARK: - User Actions
    
    case didTapAppendFolderButton
    case didTapArticle(Article)
    case didTapArticleExitButton
    case didTapProjectFolder(card: Card)
    case didTapChecklistCompleteButton(checkBox: CheckBox)
    case didTapNavigateToDetailChecklist(card: Card)
    
    // MARK: - Internal Actions
    
    case setCards([Checklist])
    case setArticles([Article])
    case setSelectedCard(card: Card?)
    case isLoadingChanged(isLoading: Bool)
    case onAppendChecklist(checklist: Checklist)
    case updateSelectedCardAfterDelay(index: Int)
    case completeCheckBox(checkBox: CheckBox)
    case deleteCheckBox(checkBox: CheckBox)
    
    // MARK: - Navigation
    
    case onPresentChat
    
    // MARK: - Delegate Actions(parent)
    
    case onNaviagteToDetailChecklist(card: Card)
    
    // MARK: - Scope Actions(child)
    
    case onCompleteCheckBox(checkBox: CheckBox)
    case onDeleteCheckBox(checkBox: CheckBox)
    case onDeleteCard(card: Card)
  }
  
  public init() {}
  
  // MARK: - Dependencies
  
  @Dependency(HomeAPIClient.self) var homeAPIClient
  @Dependency(ChecklistAPIClient.self) var checklistAPIClient
  @Dependency(\.continuousClock) var clock
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
        
      case .onAppear:
        guard !state.isViewDidLoad else {
          return .none
        }
        
        state.isViewDidLoad = true
        
        // TODO: - API 연동 후 수정
        //        guard let userID = state.userInfo?.userID else {
        //          return .none
        //        }
        let userID = state.userInfo?.userID ?? ""
        
        return .run { send in
          await send(.isLoadingChanged(isLoading: true))
          async let checklistsReponse = try checklistAPIClient.getChecklists(userID: userID)
//          async let articlesReponse = try homeAPIClient.fetchArticles(userID)
          
          let (
            checklists
          //            articles
          ) = try await (
//            [Checklist.mock1, Checklist.mock2]
                        checklistsReponse
            //            articlesReponse
          )
          
          await send(.setCards(checklists))
          //          await send(.setArticles(articles))
          await send(.isLoadingChanged(isLoading: false))
        } catch: { error, send in
          print(error)
          await send(.isLoadingChanged(isLoading: false))
        }
        
      case .didTapAppendFolderButton:
        return .send(.onPresentChat)
        
      case .didTapProjectFolder(let card):
        state.selectedCard = card
        state.displayedCheckBoxes = calculateDisplayedCheckBoxes(for: card)
        return .none
        
      case .didTapChecklistCompleteButton(let checkBox):
        return .send(.completeCheckBox(checkBox: checkBox))
        
      case .didTapArticle(let article):
        state.selectedArticle = article
        return .none
        
      case .didTapArticleExitButton:
        state.selectedArticle = .none
        return .none
        
      case .didTapNavigateToDetailChecklist(let card):
        return .send(.onNaviagteToDetailChecklist(card: card))
        
      case .setCards(let checklists):
        let cards: [Card] = checklists.map {
          .init(id: $0.id, title: $0.title, checkBoxList: $0.checkBoxList)
        }
        state.cards = .init(uniqueElements: cards)
        
        guard let firstCard = state.cards.first else {
          return .none
        }
        
        // 첫 번째 카드를 선택된 카드로 설정
        return .send(.setSelectedCard(card: firstCard))
        
      case .setArticles(let articles):
        state.articles = .init(uniqueElements: Array(articles.prefix(3)))
        return .none
        
      case .setSelectedCard(let card):
        state.selectedCard = card
        state.displayedCheckBoxes = calculateDisplayedCheckBoxes(for: card)
        return .none
        
      case .isLoadingChanged(let isLoading):
        state.isLoading = isLoading
        return .none
        
      case .onAppendChecklist(let checklist):
        let card = Card(
          id: checklist.id,
          title: checklist.title,
          checkBoxList: checklist.checkBoxList
        )
        
        state.cards.insert(card, at: 0)
        return .none
        
      case .updateSelectedCardAfterDelay(let index):
        state.displayedCheckBoxes = calculateDisplayedCheckBoxes(for: state.cards[index])
        return .none
        
      case .completeCheckBox(let checkBox):
        guard
          let selectedCardIndex = state.cards.firstIndex(where: { $0 == state.selectedCard }),
          let checkBoxIndex = state.cards[selectedCardIndex].checkBoxList.firstIndex(of: checkBox)
        else {
          return .none
        }
        
        state.cards[selectedCardIndex].checkBoxList[checkBoxIndex].isCompleted.toggle()
        state.cards[selectedCardIndex].calculatePercent()
        state.selectedCard = state.cards[selectedCardIndex]
        state.displayedCheckBoxes[id: checkBox.id]?.isCompleted.toggle()
        
        return .merge(
          .run { send in
            try await self.clock.sleep(for: .seconds(0.5))
            await send(.updateSelectedCardAfterDelay(index: selectedCardIndex))
          }.animation(.easeIn),
          .run { send in
            _ = try await checklistAPIClient.complete(
              checklistId: checkBox.checklistId,
              id: checkBox.id,
              completed: checkBox.isCompleted
            )
          } catch: { error, send in
            
          }
        )
        
      case .deleteCheckBox(let checkBox):
        guard
          let selectedCardIndex = state.cards.firstIndex(where: { $0 == state.selectedCard }),
          let checkBoxIndex = state.cards[selectedCardIndex].checkBoxList.firstIndex(of: checkBox)
        else {
          return .none
        }
        
        state.cards[selectedCardIndex].checkBoxList.remove(at: checkBoxIndex)
        state.cards[selectedCardIndex].calculatePercent()
        
        return .send(.setSelectedCard(card: state.cards[selectedCardIndex]))
        
      case .onCompleteCheckBox(let checkBox):
        return .send(.completeCheckBox(checkBox: checkBox))
        
      case .onDeleteCheckBox(let checkBox):
        return .send(.deleteCheckBox(checkBox: checkBox))
        
      case .onDeleteCard(let card):
        state.cards.remove(card)
        
        return .merge(
          // TODO: 업무 폴더 삭제, API 연동 후 테스트
          .run { send in
            _ = try await checklistAPIClient.deleteProject(checklistId: card.id)
          },
          .send(.setSelectedCard(card: state.cards.first))
        )
        
      default:
        return .none
      }
    }
  }
}

extension HomeStore {
  private func calculateDisplayedCheckBoxes(for card: Card?) -> IdentifiedArrayOf<CheckBox> {
    guard let checkBoxList = card?.checkBoxList else {
      return .init()
    }
    
    return .init(uniqueElements: checkBoxList
      .filter { !$0.isCompleted }
      .prefix(3)
    )
  }
}
