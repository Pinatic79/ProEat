import SwiftUI

struct MainPageView: View {
    @State private var foodInput: String = ""
    @State private var showAboutUs = false
    @AppStorage("userNameKey") private var userName: String = "User"

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
                
                VStack(spacing: 40) {
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
                    
                    // Greeting Section with the user's name
                    VStack {
                        Text("\(getGreeting()), \(getUserName())!")
                            .font(.system(size: 24, weight: .medium, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.top, 10)
                    }
                    
                    // Placeholder for Vector Graphics or Animation
                    VStack {
                        Image(systemName: "leaf.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150)
                            .foregroundColor(.white.opacity(0.8))
                            .shadow(radius: 10)
                        
                        Text("What's on your plate today?")
                            .font(.system(size: 18, weight: .medium, design: .rounded))
                            .foregroundColor(.white.opacity(0.8))
                            .padding(.top, 10)
                    }
                    .padding(.vertical, 20)
                    
                    // Input Section
                    VStack(spacing: 20) {
                        // TextField and Send Button
                        HStack {
                            TextField("Type the name of the food...", text: $foodInput)
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .font(.system(size: 16))
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                            
                            Button(action: {
                                print("Food input submitted: \(foodInput)")
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
                        
                        // Placeholder for "Send/Scan" Button
                        Button(action: {
                            print("Scan button tapped")
                        }) {
                            HStack {
                                
                                Spacer()
                                
                                
                            }
                          
                            .background(LinearGradient(
                                gradient: Gradient(colors: [Color.purple, Color.blue]),
                                startPoint: .leading,
                                endPoint: .trailing
                            ))
                            .cornerRadius(12)
                            .shadow(radius: 5)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                }
            }
            .navigationDestination(isPresented: $showAboutUs) {
                AboutUsView()
            }
        }
        .onAppear {
            print("Retrieved user name: \(userName)")
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

#Preview {
    MainPageView()
}
