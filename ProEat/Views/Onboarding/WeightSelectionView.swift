import SwiftUI

struct WeightSelectionView: View {
    @State private var weight: String = ""
    @State private var selectedUnit: String = "kg"
    @AppStorage("userWeight") private var storedUserWeight: Double = 0.0
    @State private var isNavigatingToDiet = false
    @FocusState private var isTextFieldFocused: Bool
    @Environment(\.dismiss) var dismiss // To enable back navigation

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.green.opacity(0.8), Color.teal.opacity(0.8)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)

                VStack(spacing: 40) {
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

                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                                .scaleEffect(isTextFieldFocused ? 1.05 : 1.0)
                                .animation(.easeInOut(duration: 0.2), value: isTextFieldFocused)

                            TextField("Enter your weight", text: $weight)
                                .keyboardType(.decimalPad)
                                .padding()
                                .frame(width: 200)
                                .background(Color.clear)
                                .font(.system(size: 18))
                                .multilineTextAlignment(.center)
                                .focused($isTextFieldFocused)
                        }
                        .frame(width: 200, height: 60)
                        .padding()

                        HStack {
                            UnitToggleButton(unit: "kg", selectedUnit: $selectedUnit)
                            UnitToggleButton(unit: "lb", selectedUnit: $selectedUnit)
                        }
                        .padding(.top, 10)
                    }

                    Image(systemName: "scalemass.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .foregroundColor(.white.opacity(0.7))

                    Spacer()

                    // Next Button using NavigationLink
                    NavigationLink(destination: DietSelectionView()) {
                        Text("Next")
                            .frame(width: 100, height: 44)
                            .background(weight.isEmpty ? Color.gray : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .shadow(radius: 5)
                            .opacity(weight.isEmpty ? 0.5 : 1.0)
                    }
                    .disabled(weight.isEmpty) // Disable button if no weight entered
                    .padding(.bottom, 40)
                    .onTapGesture {
                        saveWeightAndProceed()
                    }
                }
                .padding(.top, 80)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.blue)
                    }
                }
            }
        }
    }

    func saveWeightAndProceed() {
        if let inputWeight = Double(weight) {
            let weightInKg = selectedUnit == "lb" ? convertLbToKg(inputWeight) : inputWeight
            storedUserWeight = weightInKg
            print("Stored weight in kg: \(weightInKg)")

            // Additional logic for saving weight if needed
        }
    }

    func convertLbToKg(_ pounds: Double) -> Double {
        return pounds * 0.453592
    }
}

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
