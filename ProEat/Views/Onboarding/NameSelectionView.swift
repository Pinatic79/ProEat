import SwiftUI

struct NameSelectionView: View {
    @State private var userName: String = ""  // Local state for the text field
    @AppStorage("userName") private var storedUserName: String = ""  // Persistent storage for name

    var body: some View {
        ZStack {
            // Gradient Background
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.8)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)

            VStack(spacing: 40) {
                // Title Section
                VStack(spacing: 8) {
                    Text("Let's Get Started")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(radius: 10)

                    Text("What should we call you?")
                        .font(.system(size: 22, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.9))
                        .shadow(radius: 5)
                }

                // Name Input Field
                TextField("Enter your name", text: $userName)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    )
                    .padding(.horizontal, 40)
                    .font(.system(size: 18))
                    .multilineTextAlignment(.center)
                    .autocapitalization(.words)

                // Center Image
                Image("background-graphic1") // Ensure image exists in Assets folder
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 160)
                    .clipShape(Circle())
                    .shadow(radius: 5)

                Spacer()

                // Next Button using NavigationLink
                NavigationLink(destination: AgeSelectionView()) {
                    Text("Next")
                        .frame(width: 200, height: 50)
                        .background(userName.isEmpty ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .shadow(radius: 5)
                        .opacity(userName.isEmpty ? 0.5 : 1.0)
                }
                .disabled(userName.isEmpty) // Disable button if no input
                .padding(.bottom, 60)
                .onTapGesture {
                    saveUserName()
                }
            }
            .padding(.top, 80)
        }
        .navigationBarHidden(true)
    }

    // Save name to UserDefaults
    func saveUserName() {
        storedUserName = userName
    }
}

#Preview {
    NameSelectionView()
}
