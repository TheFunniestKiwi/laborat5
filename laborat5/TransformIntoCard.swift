//
//  TransformIntoCard.swift
//  laborat5
//
//  Created by Bartłomiej Lachowski on 04/12/2023.
//

import SwiftUI

struct TransformIntoCard: ViewModifier {
    let isFaceUp: Bool
    let color: Color

       func body(content: Content) -> some View {
           RoundedRectangle(cornerRadius: 12)
              .fill(isFaceUp ? Color.white : Color(color))
              .overlay(
                  RoundedRectangle(cornerRadius: 12)
                      .strokeBorder(lineWidth: 3)
                      .opacity(isFaceUp ? 1 : 0)
              )
              .overlay(content)
              .rotation3DEffect(
                  .degrees(isFaceUp ? 0 : 180),
                  axis: (0,1,0)
              )
       }
   }

   extension View {
       func transformIntoCard(isFaceUp: Bool, color: Color) -> some View {
           modifier(TransformIntoCard(isFaceUp: isFaceUp, color: color))
       }
   }
