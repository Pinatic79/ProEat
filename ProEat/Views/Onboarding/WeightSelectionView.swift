import SwiftUI

struct WeightSelectionView: View {
    @State private var weight: String = ""  // Local state for the weight input
    @State private var selectedUnit: String = "kg"  // Unit selection state ("kg" or "lb")
    @AppStorage("userWeight") private var storedUserWeight: Double = 0.0  // Persistent storage for weight in kg
    @State private var navigationPath = NavigationPath()  // Navigation path
    @Environment(\.dismiss) var dismiss // To enable the Back button
    @FocusState private var isTextFieldFocused: Bool  // Track if TextField is focused

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                // Gradient Background
                LinearGradient(
                    gradient: Gradient(colors: [Color.green.opacity(0.8), Color.teal.opacity(0.8)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)

                VStack(spacing: 40) {
                    // Title Section
                    VStack(spacing: 8) {
                        Text("Track Your Progress")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .shadow(radius: 10)

                        Text("What's your current weight?")
                            .font(.system(size: 22, weight: .medium, design: .rounded))
                            .foregroundColor(.white.opacity(0.9))
                            .shadow(radius: 5)
                    }

                    // Weight Input Field with Unit Toggle
                    VStack {
                        ZStack {
                            // Background of the TextField with animation
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                                .scaleEffect(isTextFieldFocused ? 1.05 : 1.0)  // Scale on focus
                                .animation(.easeInOut(duration: 0.2), value: isTextFieldFocused)

                            // TextField for Weight Input
                            TextField("Enter your weight", text: $weight)
                                .keyboardType(.decimalPad)
                                .padding()
                                .frame(width: 200)
                                .background(Color.clear)
                                .font(.system(size: 18))
                                .multilineTextAlignment(.center)
                                .focused($isTextFieldFocused) // Track focus
                        }
                        .frame(width: 200, height: 60)
                        .padding()

                        // Custom Unit Toggle Buttons
                        HStack {
                            UnitToggleButton(unit: "kg", selectedUnit: $selectedUnit)
                            UnitToggleButton(unit: "lb", selectedUnit: $selectedUnit)
                        }
                        .padding(.top, 10)
                    }

                    // Weight Illustration (Placeholder for Icon)
                    Image(systemName: "scalemass.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .foregroundColor(.white.opacity(0.7))

                    Spacer()

                    // Save and Next Button
                    Button(action: {
                        saveWeightAndProceed()
                    }) {
                        Text("Next")
                            .frame(width: 100, height: 44)
                            .background(weight.isEmpty ? Color.gray : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .shadow(radius: 5)
                            .opacity(weight.isEmpty ? 0.5 : 1.0)
                    }
                    .disabled(weight.isEmpty) // Disable button if no input
                    .padding(.bottom, 40)
                }
                .padding(.top, 80)
            }
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

    // Convert and save weight and unit to kilograms
    func saveWeightAndProceed() {
        if let inputWeight = Double(weight) {
            let weightInKg = selectedUnit == "lb" ? convertLbToKg(inputWeight) : inputWeight
            storedUserWeight = weightInKg  // Store the converted weight in kilograms
            print("Stored weight in kg: \(weightInKg)")

            // Navigate to the next screen
            navigationPath.append("GenderSelectionView")
        }
    }

    // Convert pounds to kilograms
    func convertLbToKg(_ pounds: Double) -> Double {
        return pounds * 0.453592
    }
}

// Custom Unit Toggle Button Component
struct UnitToggleButton: View {
    let unit: String
    @Binding var selectedUnit: String

    var body: some View {
        Text(unit)
            .font(.system(size: 18, weight: .medium, design: .rounded))
            .foregroundColor(selectedUnit == unit ? .white : .gray)
            .padding()
            .frame(width: 80)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(selectedUnit == unit ? Color.blue : Color.white)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
            )
            .onTapGesture {
                selectedUnit = unit
            }
            .animation(.easeInOut(duration: 0.2), value: selectedUnit)
    }
}

#Preview {
    WeightSelectionView()
}
