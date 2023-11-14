//
//  laborat5App.swift
//  laborat5
//
//  Created by student on 14/11/2023.
//

import SwiftUI

@main
struct laborat5App: App {
    var body: some Scene {
        @StateObject var game = MemoGameViewModel()
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
