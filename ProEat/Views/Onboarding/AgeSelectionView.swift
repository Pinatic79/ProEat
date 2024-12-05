import SwiftUI

struct AgeSelectionView: View {
    @State private var age: String = ""  // Local state for the text field
    @AppStorage("userAge") private var storedUserAge: Int = 0  // Persistent storage for age
    @Environment(\.dismiss) var dismiss // To enable the Back button

    var body: some View {
        NavigationStack {
            ZStack {
                // Gradient Background
                LinearGradient(
                    gradient: Gradient(colors: [Color.orange.opacity(0.8), Color.pink.opacity(0.8)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)

                VStack(spacing: 40) {
                    // Title Section
                    VStack(spacing: 8) {
                        Text("Another Question...")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .shadow(radius: 10)
        
                        Text("How old are you?")
                            .font(.system(size: 22, weight: .medium, design: .rounded))
                            .foregroundColor(.white.opacity(0.9))
                            .shadow(radius: 5)
                    }

                    // Age Input Field
                    TextField("Enter your age", text: $age)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                        )
                        .padding(.horizontal, 40)
                        .font(.system(size: 18))
                        .multilineTextAlignment(.center)

                    Spacer()

                    // Next Button using NavigationLink
                    NavigationLink(destination: GenderSelectionView()) {
                        Text("Next")
                            .frame(width: 200, height: 50)
                            .background(age.isEmpty ? Color.gray : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .shadow(radius: 5)
                            .opacity(age.isEmpty ? 0.5 : 1.0)
                    }
                    .disabled(age.isEmpty) // Disable button if no input
                    .padding(.bottom, 60)
                    .onTapGesture {
                        saveAge()
                    }
                }
                .padding(.top, 80)
            }
            .navigationBarTitleDisplayMode(.inline) // Ensure title doesn't take up too much space
            .navigationBarBackButtonHidden(true) // Hide the default back button
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss() // Navigate back to the previous screen
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.blue)
                    }
                }
            }
        }
    }

    // Save age to UserDefaults
    func saveAge() {
        if let ageNumber = Int(age), ageNumber > 0 {
            storedUserAge = ageNumber
        }
    }
}

#Preview {
    AgeSelectionView()
}
