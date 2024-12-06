import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            EntryPageView()  // The first onboarding page
                .preferredColorScheme(.light)
        }
    }
}

#Preview {
    ContentView()
}
