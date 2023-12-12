import SwiftUI

struct TransformIntoCard: ViewModifier {
    let isFaceUp: Bool
    let color: Color

       func body(content: Content) -> some View {
           RoundedRectangle(cornerRadius: 3)
              .fill(isFaceUp ? Color.white : Color(color))
              .overlay(
                  RoundedRectangle(cornerRadius: 3)
                      .strokeBorder(lineWidth: 1)
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
