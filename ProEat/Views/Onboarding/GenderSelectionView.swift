import SwiftUI

struct GenderSelectionView: View {
    @State private var selectedGender: String = "" // Store selected gender
    @AppStorage("userGender") private var storedUserGender: String = "" // Persistent storage for gender
    @Environment(\.dismiss) var dismiss // To enable the Back button

    var body: some View {
        NavigationStack {
            ZStack {
                // Gradient Background
                LinearGradient(
                    gradient: Gradient(colors: [Color.pink.opacity(0.8), Color.purple.opacity(0.8)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)

                VStack(spacing: 40) {
                    // Title Section
                    VStack(spacing: 8) {
                        Text("A Few More Details")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .shadow(radius: 10)

                        Text("What is your gender?")
                            .font(.system(size: 22, weight: .medium, design: .rounded))
                            .foregroundColor(.white.opacity(0.9))
                            .shadow(radius: 5)
                    }

                    // Gender Selection Buttons
                    HStack(spacing: 20) {
                        GenderButton(iconName: "person.fill", label: "Male", selectedGender: $selectedGender)
                        GenderButton(iconName: "person.2.fill", label: "Female", selectedGender: $selectedGender)
                        GenderButton(iconName: "person.crop.circle.badge.questionmark", label: "Other", selectedGender: $selectedGender)
                    }
                    .padding(.horizontal, 20)

                    Spacer()

                    // Navigation buttons
                    HStack {
                        // Back Button
                        

                        // Next Button using NavigationLink
                        NavigationLink(destination: WeightSelectionView()) {
                            Text("Next")
                                .frame(width: 200, height: 50)
                                .background(selectedGender.isEmpty ? Color.gray : Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .shadow(radius: 5)
                                .opacity(selectedGender.isEmpty ? 0.5 : 1.0)
                        }
                        .disabled(selectedGender.isEmpty) // Disable button if no gender selected
                    }
                    .padding(.bottom, 60)
                }
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
}

struct GenderButton: View {
    let iconName: String
    let label: String
    @Binding var selectedGender: String

    var body: some View {
        VStack {
            Image(systemName: iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(selectedGender == label ? .white : .gray)

            Text(label)
                .font(.system(size: 18, weight: .medium, design: .rounded))
                .foregroundColor(selectedGender == label ? .white : .gray)
        }
        .padding()
        .frame(width: 120, height: 150)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(selectedGender == label ? Color.blue : Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
        )
        .onTapGesture {
            selectedGender = label
        }
        .animation(.easeInOut(duration: 0.2), value: selectedGender)
    }
}

#Preview {
    GenderSelectionView()
}
