import SwiftUI

@main
struct ProEatApp: App {
    @AppStorage("isOnboardingComplete") private var isOnboardingComplete: Bool = false

    var body: some Scene {
        WindowGroup {
            if isOnboardingComplete {
                ContentView() // Main app content
            } else {
                EntryPageView() // Start onboarding
            }
        }
    }
}
