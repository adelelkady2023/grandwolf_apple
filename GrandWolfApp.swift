import SwiftUI

@main
struct GrandWolfApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(appState)
                .environment(\.layoutDirection, appState.isArabic ? .rightToLeft : .leftToRight)
        }
    }
}
