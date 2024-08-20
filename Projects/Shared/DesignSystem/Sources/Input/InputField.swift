//
//  InputField.swift
//  SharedDesignSystem
//
//  Created by 현수빈 on 8/20/24.
//

import SwiftUI

public struct InputField<T: Hashable>: View {
  
  @Binding var errorMessage: String?
  @Binding var text: String
  
  private let placeHolder: String
  private let isFocused: FocusState<T>.Binding
  private let focusValue: T
  
  public init(
    errorMessage: Binding<String?>,
    text: Binding<String>,
    placeHolder: String,
    isFocused: FocusState<T>.Binding,
    focusValue: T = true
  ) {
    self._errorMessage = errorMessage
    self._text = text
    self.placeHolder = placeHolder
    self.isFocused = isFocused
    self.focusValue = focusValue
  }
  
  public var body: some View {
    VStack {
      HStack {
        
        ZStack(alignment: .leading) {
          TextField(
            placeHolder,
            text: $text
          )
            .notoSans(.body_2)
            .foregroundStyle(Color.greyScale950)
            .focused(isFocused, equals: focusValue)
          
          
            if isFocused.wrappedValue != focusValue {
              Text(placeHolder)
                .foregroundStyle(Color.black)
                .frame(maxWidth: .infinity, alignment: .center)
                .onTapGesture {
                  isFocused.wrappedValue = focusValue
                }
            }
        }
        
        
        if isFocused.wrappedValue == focusValue {
          Spacer()
          Button(action: {
            text.removeAll()
          }) {
            SharedDesignSystemAsset.Image.closeCross
              .swiftUIImage
              .resizable()
              .scaledToFit()
              .foregroundStyle(Color.white)
              .frame(width: 16)
              .background(Color.init(hex: "DFDFDF"))
              .clipShape(Circle())
          }
        }
      }
      .padding(.horizontal, 12)
      .frame(maxWidth: .infinity)
      .frame(height: 56)
      .background(
        isFocused.wrappedValue == focusValue || errorMessage != nil
        ? Color.white
        : Color.greyScale050
      )
      .clipShape(RoundedRectangle(cornerRadius: 10))
      .overlay {
        RoundedRectangle(cornerRadius: 10)
          .stroke(
            errorMessage == nil
            ? (isFocused.wrappedValue == focusValue ? Color.greyScale700: Color.clear)
            : Color.init(hex: "F05C2E"),
            lineWidth: 1
          )
      }
      
      if let errorMessage {
        HStack {
          Text(errorMessage)
            .foregroundStyle(Color.init(hex: "F05C2E"))
            .notoSans(.caption)
            .multilineTextAlignment(.leading)
          
          Spacer()
        }
      }
      
    }
  }
}
