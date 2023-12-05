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
