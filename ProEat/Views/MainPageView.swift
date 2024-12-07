import SwiftUI

struct MainPageView: View {
    @State private var foodInput: String = ""
    @State private var showAboutUs = false
    @State private var animateView = false
    @AppStorage("userNameKey") private var userName: String = "User"
    @State private var keyboardHeight: CGFloat = 0

    var body: some View {
        NavigationStack {
            ZStack {
                // Gradient Background
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.8)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 30) {
                        // Header Section
                        HStack {
                            Text("ProEat")
                                .font(.system(size: 32, weight: .bold, design: .rounded))
                                .foregroundColor(.white)

                            Spacer()

                            Button(action: {
                                showAboutUs = true
                            }) {
                                Image(systemName: "gearshape.fill")
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .shadow(radius: 5)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 40)
                        .opacity(animateView ? 1 : 0)
                        .offset(y: animateView ? 0 : -50)

                        // Greeting Section with the user's name
                        VStack(alignment: .leading, spacing: 5) {
                            Text("\(getGreeting()),")
                                .font(.system(size: 22, weight: .medium, design: .rounded))
                                .foregroundColor(.white.opacity(0.8))

                            Text("\(getUserName())!")
                                .font(.system(size: 28, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                        .opacity(animateView ? 1 : 0)
                        .offset(y: animateView ? 0 : 50)

                        // Placeholder for Vector Graphics or Animation
                        VStack {
                            Image(systemName: "leaf.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 150)
                                .foregroundColor(.white.opacity(0.8))
                                .shadow(radius: 10)
                                .scaleEffect(animateView ? 1 : 0.5)

                            Text("What's on your plate today?")
                                .font(.system(size: 18, weight: .medium, design: .rounded))
                                .foregroundColor(.white.opacity(0.8))
                                .padding(.top, 10)
                        }
                        .padding(.vertical, 20)
                        .opacity(animateView ? 1 : 0)

                        // Input Section
                        VStack(spacing: 20) {
                            // TextField and Send Button
                            HStack {
                                TextField("Type the name of the food...", text: $foodInput)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.white.opacity(0.2))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                            )
                                    )
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                                    .font(.system(size: 16))
                                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                                    .textInputAutocapitalization(.never)
                                    .autocorrectionDisabled()

                                Button(action: {
                                    print("Food input submitted: \(foodInput)")
                                    hideKeyboard()
                                }) {
                                    Image(systemName: "paperplane.fill")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(LinearGradient(
                                            gradient: Gradient(colors: [Color.orange, Color.pink]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        ))
                                        .clipShape(Circle())
                                        .shadow(radius: 10)
                                }
                            }
                            .padding(.horizontal, 20)
                            .opacity(animateView ? 1 : 0)
                            .offset(y: animateView ? 0 : 50)

                            // Scan Food Section
                            VStack {
                                Button(action: {
                                    print("Camera button tapped")
                                }) {
                                    Image(systemName: "camera.fill")
                                        .font(.largeTitle)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(LinearGradient(
                                            gradient: Gradient(colors: [Color.purple, Color.blue]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ))
                                        .clipShape(Circle())
                                        .shadow(radius: 10)
                                }
                                .padding(.top, 20)
                            }
                        }

                        // Add extra padding at the bottom to ensure content is visible above keyboard
                        Spacer(minLength: keyboardHeight + 50)
                    }
                }
            }
            .navigationDestination(isPresented: $showAboutUs) {
                AboutUsView()
            }
        }
        .onAppear {
            print("Retrieved user name: \(userName)")
            
            // Animate the view when it appears
            withAnimation(.spring(response: 0.7, dampingFraction: 0.8)) {
                animateView = true
            }
            
            // Add keyboard observers
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    keyboardHeight = keyboardFrame.height
                }
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                keyboardHeight = 0
            }
        }
    }

    // Function to get a greeting based on the current time
    private func getGreeting() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        if hour >= 5 && hour < 12 {
            return "Good morning"
        } else if hour >= 12 && hour < 18 {
            return "Good afternoon"
        } else {
            return "Good evening"
        }
    }

    // Function to safely retrieve username
    private func getUserName() -> String {
        let trimmedName = userName.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedName.isEmpty ? "User" : trimmedName
    }
}

// Extension to hide keyboard
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    MainPageView()
}
