import SwiftUI

struct ConsentPageView: View {
    @State private var agreedToTerms: Bool = false
    @State private var agreedToGuidance: Bool = false
    @State private var agreedToUnderstanding: Bool = false
    @AppStorage("isOnboardingComplete") private var isOnboardingComplete: Bool = false

    var body: some View {
        ZStack {
            // Gradient Background
            LinearGradient(
                gradient: Gradient(colors: [Color.purple.opacity(0.8), Color.orange.opacity(0.8)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                VStack(spacing: 10) {
                    Text("✨ Last Step! ✨")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(radius: 10)
                        .padding(.bottom, 10)

                    Text("Please review and agree to the following:")
                        .font(.system(size: 20, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .lineSpacing(5)
                        .padding(.horizontal, 30)
                        .shadow(radius: 5)
                }
                .padding(.top, 40)

                VStack(alignment: .leading, spacing: 25) {
                    ConsentCheckbox(isChecked: $agreedToTerms, text: "I agree to this app's Terms and Conditions and Privacy Policy.")
                    ConsentCheckbox(isChecked: $agreedToGuidance, text: "I agree to use this app as a general guidance tool, not as a substitute for professional medical advice.")
                    ConsentCheckbox(isChecked: $agreedToUnderstanding, text: "I understand that this app is not intended to diagnose, treat, or replace professional advice.")
                }
                .padding(.horizontal, 20)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white.opacity(0.2))
                        .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                )
                .padding(.horizontal, 20)

                Spacer()

                Button(action: {
                    // Mark onboarding as complete when user clicks "Let's Go"
                    isOnboardingComplete = true
                }) {
                    Text("Let's Go")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(
                            Group {
                                if agreedToTerms && agreedToGuidance && agreedToUnderstanding {
                                    LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing)
                                } else {
                                    Color.gray.opacity(0.6)
                                }
                            }
                        )
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .shadow(radius: 5)
                }
                .disabled(!(agreedToTerms && agreedToGuidance && agreedToUnderstanding))
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
        }
    }
}

struct ConsentCheckbox: View {
    @Binding var isChecked: Bool
    let text: String

    var body: some View {
        HStack(alignment: .top) {
            Button(action: {
                isChecked.toggle()
            }) {
                Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                    .foregroundColor(isChecked ? .blue : .gray)
                    .font(.system(size: 28))
            }

            Text(text)
                .font(.system(size: 18, weight: .regular, design: .rounded))
                .foregroundColor(.white)
                .padding(.leading, 12)
                .multilineTextAlignment(.leading)
                .lineSpacing(6)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.vertical, 5)
    }
}

#Preview {
    ConsentPageView()
}
