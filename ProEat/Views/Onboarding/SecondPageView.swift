import SwiftUI

struct SecondPageView: View {
    @Environment(\.dismiss) var dismiss // To enable the Back button
    @State private var isAnimating = false

    var body: some View {
        NavigationStack {
            VStack {
                // Greeting and Logo Section with Animations
                HStack {
                    VStack(alignment: .leading) {
                        Text("👋") // Hand emoji
                            .font(.largeTitle)
                            .opacity(isAnimating ? 1.0 : 0.0)
                            .animation(.easeIn(duration: 0.3).delay(0.2), value: isAnimating)
                        
                        Text("Hello!")
                            .font(.title)
                            .fontWeight(.bold)
                            .opacity(isAnimating ? 1.0 : 0.0)
                            .animation(.easeIn(duration: 0.3).delay(0.1), value: isAnimating)
                    }
                    Spacer()
                    
                    // Logo with fade-in effect
                    Image("logo") // Ensure AppLogo exists in Assets folder
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle()) // Circular shape for logo
                        .opacity(isAnimating ? 1.0 : 0.0)
                        .animation(.easeIn(duration: 0.5).delay(0.4), value: isAnimating)
                }
                .padding(.horizontal, 20)
                .onAppear {
                    isAnimating = true
                }

                // App Description Section
                Spacer()
                Text("Discover the best foods to eat for your diet plan. Get personalized recommendations based on your dietary goals.")
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .foregroundColor(.black)
                    .padding(.horizontal, 30)
                    .opacity(isAnimating ? 1.0 : 0.0)
                    .animation(.easeIn(duration: 0.5).delay(0.5), value: isAnimating)

                Spacer()

                // Disclaimer Section with some margin
                VStack(alignment: .leading, spacing: 8) {
                    Text("Note:")
                        .font(.headline)
                        .fontWeight(.bold)

                    Text("This app provides general dietary advice and is not a substitute for professional medical advice. Always consult a healthcare provider before making significant changes to your diet.")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                }
                .padding(.horizontal, 30)
                .opacity(isAnimating ? 1.0 : 0.0)
                .animation(.easeIn(duration: 0.5).delay(0.5), value: isAnimating)

                Spacer()

                // Next Button with animation and hover effect
                HStack {
                    Spacer()
                    NavigationLink(destination: NameSelectionView()) {
                        Text("Next")
                            .frame(width: 100, height: 44)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .scaleEffect(isAnimating ? 1.1 : 1.0)
                            .opacity(isAnimating ? 1.0 : 0.0)
                            .animation(.easeIn(duration: 0.3).delay(0.9), value: isAnimating)
                    }
                    .padding(.trailing, 30)
                    .padding(.bottom, 20)
                }
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline) // Consistent title style
            .navigationBarBackButtonHidden(true) // Hide the default back button
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss() // Navigate back
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.blue) // Match other page styles
                    }
                }
            }
        }
    }
}

#Preview {
    SecondPageView()
}
