import SwiftUI

struct DietSelectionView: View {
    @State private var selectedDiet: String? = nil
    @State private var showDietInfo: Bool = false
    @State private var selectedDietDescription: String = ""
    @AppStorage("userDietPreference") private var storedDietPreference: String = ""
    @Environment(\.dismiss) var dismiss

    let diets = [
        "Sugar Free": "Eliminate added sugars for a balanced blood sugar level.",
        "Keto": "Low carb, high fat diet to help burn fat more effectively.",
        "Gluten Free": "Avoid gluten for improved digestion and reduced inflammation.",
        "Protein Rich": "High protein intake to support muscle growth and repair.",
        "Healthy Diet": "A balanced diet for overall health and well-being."
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.orange.opacity(0.8), Color.pink.opacity(0.8)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)

                VStack(spacing: 40) {
                    VStack(spacing: 8) {
                        Text("Choose Your Diet")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .shadow(radius: 10)

                        Text("What kind of diet suits your goals?")
                            .font(.system(size: 22, weight: .medium, design: .rounded))
                            .foregroundColor(.white.opacity(0.9))
                            .shadow(radius: 5)
                    }

                    VStack(spacing: 20) {
                        ForEach(diets.keys.sorted(), id: \.self) { diet in
                            Button(action: {
                                // Set the selected diet and its description
                                selectedDiet = diet
                                selectedDietDescription = diets[diet] ?? ""
                            }) {
                                HStack {
                                    Text(diet)
                                        .font(.headline)
                                        .foregroundColor(selectedDiet == diet ? .white : .black)
                                    
                                    Spacer()
                                    
                                    if selectedDiet == diet {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.white)
                                    }
                                    
                                    // Info Button
                                    Button(action: {
                                        // Explicitly set the description and show sheet
                                        updateDietInfoAndShowSheet(for: diet)
                                    }) {
                                        Image(systemName: "info.circle.fill")
                                            .foregroundColor(selectedDiet == diet ? .white : .gray)
                                            .padding(.trailing, 10)
                                    }
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(selectedDiet == diet ? Color.blue : Color.white)
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                            }
                            .padding(.horizontal)
                        }
                    }

                    Spacer()

                    // Next Button using NavigationLink
                    NavigationLink(destination: ConsentPageView()) {
                        Text("Next")
                            .frame(width: 100, height: 44)
                            .background(selectedDiet == nil ? Color.gray : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .shadow(radius: 5)
                            .opacity(selectedDiet == nil ? 0.5 : 1.0)
                    }
                    .disabled(selectedDiet == nil)
                    .padding(.bottom, 40)
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

            // Info Sheet Display Logic
            .sheet(isPresented: $showDietInfo) {
                // Show the info sheet with the updated description
                DietInfoSheetView(description: selectedDietDescription)
            }
        }
    }

    // New method to update diet info and show sheet
    func updateDietInfoAndShowSheet(for diet: String) {
        // Explicitly set the description
        selectedDietDescription = diets[diet] ?? ""
        
        // Show the info sheet after the description is set
        if !selectedDietDescription.isEmpty {
            showDietInfo = true
        }
    }

    func saveDietPreferenceAndProceed() {
        if let selectedDiet = selectedDiet {
            storedDietPreference = selectedDiet
            print("Selected Diet: \(selectedDiet)")
            // Proceed to next page or handle further actions
        }
    }
}

struct DietInfoSheetView: View {
    let description: String
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 20) {
            Text("Diet Information")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(12)
                .shadow(radius: 5)

            ScrollView {
                Text(description)
                    .font(.body)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(12)
                    .padding(.horizontal)
            }

            Button(action: {
                dismiss() // Dismiss the sheet when clicked
            }) {
                Text("Close")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .font(.title3)
            }
            .padding()
        }
        .background(Color.pink.opacity(0.9))
        .cornerRadius(12)
        .padding()
    }
}

#Preview {
    DietSelectionView()
}
