import SwiftUI

struct EntryPageView: View {
    @State private var selectedImageIndex = 0
    let images = ["healthy_food1", "healthy_food2", "healthy_food3"] // Replace with your image names
    
    var body: some View {
        VStack(spacing: 20) {
            // Welcome Text
            Text("Welcome to ProEat")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top, 50)
            
            // Image Carousel
            TabView(selection: $selectedImageIndex) {
                ForEach(images.indices, id: \.self) { index in
                    Image(images[index])
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(15)
                        .padding(.horizontal, 30)
                        .tag(index)
                }
            }
            .frame(height: 300)
            .tabViewStyle(PageTabViewStyle())
            .animation(.easeInOut(duration: 0.5), value: selectedImageIndex)

            // Subtext Below Carousel
            Text("Ready to discover the best foods for your dietary plan?")
                .font(.headline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
            
            // Start Button
            Button(action: {
                // Navigate to the next page (SecondPageView)
                // You can replace SecondPageView() with your actual next page
                // This requires setting up navigation in ContentView later
            }) {
                Text("Start")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(25)
            }
            .padding(.bottom, 50)

            Spacer()
        }
        .background(Color.white.ignoresSafeArea())
    }
}

struct EntryPageView_Previews: PreviewProvider {
    static var previews: some View {
        EntryPageView()
    }
}
