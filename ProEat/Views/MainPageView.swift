import SwiftUI

struct MainPageView: View {
    @State private var foodInput: String = ""
    
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
                            print("Settings button tapped")
                        }) {
                            Image(systemName: "gearshape.fill")
                                .foregroundColor(.white)
                                .font(.title2)
                                .shadow(radius: 5)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 40)
                    
                    // Placeholder for Vector Graphics or Animation
                    VStack {
                        Image(systemName: "leaf.circle.fill") // Replace with your graphic or animation
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
                                Text("Send/Scan the food")
                                    .font(.system(size: 18, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                Image(systemName: "arrow.right")
                                    .foregroundColor(.white)
                                    .font(.title3)
                            }
                            .padding()
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
        }
    }
}

#Preview {
    MainPageView()
}
