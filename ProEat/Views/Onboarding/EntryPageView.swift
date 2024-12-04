import SwiftUI

struct EntryPageView: View {
    let images = ["healthyEating1", "workout1", "healthyEating2"]
    @State private var currentIndex = 0

    var body: some View {
        NavigationStack {
            VStack {
                // Fixed Welcome Text
                Text("Welcome to ProEat!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .padding()
                    .shadow(radius: 15)

                // Image Carousel
                TabView(selection: $currentIndex) {
                    ForEach(0..<images.count, id: \.self) { index in
                        Image(images[index])
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                            .padding()
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .frame(height: 400)

                // Description Text
                Text("Ready to discover the best foods for your dietary plan?")
                    .font(.headline)
                    .padding(.top, 20)
                    .multilineTextAlignment(.center)

                // Start Button
                NavigationLink(destination: SecondPageView()) {
                    Text("Start")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding()
            }
        }
    }
}

#Preview {
    EntryPageView()
}
