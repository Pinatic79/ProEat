import SwiftUI

@main
struct ProEatApp: App {
    @AppStorage("isOnboardingComplete") private var isOnboardingComplete: Bool = false

    var body: some Scene {
        WindowGroup {
            // Only check the onboarding status here, and show either ContentView or EntryPageView
            if isOnboardingComplete {
                ContentView() // Navigate to main content view if onboarding is complete
            } else {
                EntryPageView() // Show the entry page if onboarding is not complete
            }
        }
    }
}
