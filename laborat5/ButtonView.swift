//
//  ButtonView.swift
//  laborat5
//
//  Created by student on 14/11/2023.
//

import SwiftUI

struct ButtonView : View {
    var action: () -> Void
    var symbol: Image
    var text: String = ""
    var body: some View {
        VStack{
            Text(symbol)
            Text(text)
        }.onTapGesture {
            action()
        }
    }
}

