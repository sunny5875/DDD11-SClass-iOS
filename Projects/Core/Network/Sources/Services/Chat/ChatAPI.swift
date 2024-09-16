//
//  ChatAPI.swift
//  CoreNetwork
//
//  Created by 현수빈 on 9/8/24.
//

import Foundation

import CoreDomain

import Moya

enum ChatAPI {
  case createSession(_ userId: String)
  case sendMessage(_ dto: SendMessageRequestDTO, sessionId: String)
  case getMessage(_ sessionId: String)
}

extension ChatAPI: BaseAPI {
  
  var baseURL: URL {
    return URL(string: "")!
  }
  
  var domain: OnboardingKitDomain {
    return .chat
  }
  
  var method: Moya.Method {
    switch self {
    case .createSession:
      return .post
    case .sendMessage:
      return .post
    case .getMessage:
      return .get
    }
  }
  
  var urlPath: String {
    switch self {
    case .createSession:
      return "/"
    case .sendMessage( _, let sessionId):
      return "/\(sessionId)/messages/"
    case .getMessage(let sessionId):
      return "/\(sessionId)/messages/"
      
    }
  }
  
  var parameters: [String: Any]? {
    switch self {
    case .createSession(let id):
      return [
        "userId": id
      ]
    case .sendMessage(let dto, _):
      return [
        "message": dto.message
      ]
    default:
      return .none
    }
  }

  
  var error: [Int: NetworkError]? {
    return nil
  }
}
