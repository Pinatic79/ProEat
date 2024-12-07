import SwiftUI

struct AboutUsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var animationProgress: CGFloat = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Gradient Background matching main app theme
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.8)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)
                
                // Animated Background Elements
                GeometryReader { geometry in
                    ZStack {
                        // Animated Circles
                        ForEach(0..<5) { index in
                            Circle()
                                .fill(Color.white.opacity(0.1))
                                .frame(width: 100 + CGFloat(index * 50), height: 100 + CGFloat(index * 50))
                                .position(x: geometry.size.width * 0.8, y: geometry.size.height * 0.2)
                                .scaleEffect(1 + CGFloat(index) * 0.2 * animationProgress)
                                .opacity(0.3 * (1 - animationProgress))
                                .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true).delay(Double(index) * 0.2), value: animationProgress)
                        }
                    }
                }
                
                VStack(spacing: 30) {
                    // App Logo or Icon
                    Image("logo")
                        
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 140, height: 140)
                        .cornerRadius(80)
                        .foregroundColor(.white)
                        .shadow(radius: 10)
                        .scaleEffect(1 + 0.1 * animationProgress)
                        .animation(.spring(response: 0.5, dampingFraction: 0.5), value: animationProgress)
                    
                    // About Section
                    VStack(spacing: 15) {
                        Text("ProEat")
                            .font(.system(size: 36, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .shadow(radius: 5)
                        
                        Text("Developed by Pinatic")
                            .font(.system(size: 22, weight: .medium, design: .rounded))
                            .foregroundColor(.white.opacity(0.8))
                            .shadow(radius: 3)
                    }
                    .opacity(animationProgress)
                    .animation(.easeInOut(duration: 1), value: animationProgress)
                    
                    // Version and Details
                    VStack(spacing: 10) {
                        Text("Version 1.0.0")
                            .font(.system(size: 18, weight: .light, design: .rounded))
                            .foregroundColor(.white.opacity(0.7))
                        
                        Text("© 2024 Pinatic. All rights reserved.")
                            .font(.system(size: 16, weight: .light, design: .rounded))
                            .foregroundColor(.white.opacity(0.6))
                    }
                    .opacity(animationProgress)
                    .animation(.easeInOut(duration: 1).delay(0.5), value: animationProgress)
                }
                .padding()
                .multilineTextAlignment(.center)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.white.opacity(0.2))
                            .clipShape(Circle())
                    }
                }
            }
        }
        .onAppear {
            animationProgress = 1
        }
        .onDisappear {
            animationProgress = 0
        }
    }
}

#Preview {
    AboutUsView()
}
