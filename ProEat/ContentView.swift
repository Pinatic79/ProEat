import SwiftUI

struct ContentView: View {
    @AppStorage("isOnboardingComplete") private var isOnboardingComplete: Bool = false

    var body: some View {
        NavigationStack {
            // If onboarding is complete, show the main page, else show the entry page.
            if isOnboardingComplete {
                MainPageView() // Show MainPageView after onboarding
            } else {
                EntryPageView() // Show EntryPageView if onboarding is incomplete
            }
        }
    }
}

#Preview {
    ContentView()
}
