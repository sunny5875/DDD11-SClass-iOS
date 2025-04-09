//
//  ChatStore.swift
//  FeatureChat
//
//  Created by 홍은표 on 8/15/24.
//

import Foundation

import Core

import ComposableArchitecture


@Reducer
public struct ChatStore {
  public init() { }
  
  @ObservableState
  public struct State {
    var chatMessage = ""
    var chatList: [MessageEntity] = []
    var isPresented: Bool = false
    
    var session: ChatSession? = nil
    public init() {}
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    
    // 세션 만들기
    case onAppear
    case onCompleteCreateSession(TaskResult<ChatSession>)
    
    // 메세지 보내기
    case didTapSendButton(String?)
    case onCompleteSend(TaskResult<Message>)
    case didTapCreateChecklistButton(MessageEntity)
    case onCompleteCreateChecklist(Int)
    
    
    // 나가기
    case didTapExitButton
    case didTapExitConfirmButton
    case didTapExitCancelButton
    case onCloseView
  }
  
  
  @Dependency(KeychainClient.self) var keychainClient
  @Dependency(ChatAPIClient.self) var chatAPIClient
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
      case .onAppear:
        guard let userId = keychainClient.userID
        else { return .none }
        return .run { send in
          do {
            let newSession = try await chatAPIClient.createSession(userId)
            await send(.onCompleteCreateSession(.success(newSession)))
          } catch {
            await send(.onCompleteCreateSession(.failure(error)))
          }
        }
      case .onCompleteCreateSession(.success(let response)):
        state.session = response
        state.chatList.append(
          .init(
            title: "",
            content: "안녕하세요! 궁금한 업무를 물어보시면\n이에 대한 체크리스트를 생성해드려요!",
            type: .answer
          )
        )
        return .none
      case .onCompleteCreateSession(.failure(_)):
        return .none
        
        
      case .didTapSendButton(let exampleMessage):
        return sendMessage(state: &state, newMessage: exampleMessage ?? state.chatMessage)
      case .onCompleteSend(.success(let chatResponse)):
        if let url = chatResponse.text.range(
          of: "https?://[a-zA-Z0-9./_-]+",
          options: .regularExpression
        ) {
            let path = chatResponse.text[url].components(separatedBy: "/")
            if path.count == 7  {
                state.chatList.append(
                    .init(
                        title: "체크리스트 생성 완료",
                        content: "탭을 하여 체크리스트를 확인해보세요",
                        type: .info,
                        path: path[5]
                    )
                )
            }
            else {
                state.chatList.append(
                  .init(
                    title: chatResponse.text,
                    content: chatResponse.text,
                    type: .answer
                  )
                )
            }
        } else {
          state.chatList.append(
            .init(
              title: chatResponse.text,
              content: chatResponse.text,
              type: .answer
            )
          )
        }
        return .none
      case .onCompleteSend(.failure):
        return .none
        
      case .didTapCreateChecklistButton(let message):
        if let path = message.path {
          return .send(.onCompleteCreateChecklist(Int(path) ?? -1))
        } else {
          return .none
        }
      case .didTapExitButton:
        state.isPresented = true
        return .none
      case .didTapExitConfirmButton:
        state.isPresented = false
        return .send(.onCloseView)
      case .didTapExitCancelButton:
        state.isPresented = false
        return .none
      case .onCloseView:
        return .none
      case .onCompleteCreateChecklist(_):
        return .none
      }
    }
  }
  
  private func sendMessage(state: inout State, newMessage: String) -> Effect<Action> {
    state.chatList.append(
      .init(
        title: newMessage,
        content: newMessage,
        type: .question
      )
    )
    state.chatMessage.removeAll()
    guard let session = state.session
    else { return .none }
    
    return .run { send in
      do {
        let message = try await chatAPIClient.sendMessage(session, newMessage)
        await send(.onCompleteSend(.success(message)))
      } catch {
        await send(.onCompleteSend(.failure(error)))
      }
    }
  }
}

