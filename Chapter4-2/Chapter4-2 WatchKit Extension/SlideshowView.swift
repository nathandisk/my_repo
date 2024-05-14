import SwiftUI

// A view displaying a slideshow of images
struct SlideshowView: View {
    // Array of image names
    let imageNames = ["bromo", "bromo1", "bromo2", "bromo3"]
    // State variable to track the current index of the slideshow
    @State private var currentIndex = 0
    // Timer for automatic slideshow
    @State private var timer: Timer? = nil
    
    var body: some View {
        VStack {
            // Horizontal ScrollView for displaying images
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    // Iterate over image names to display images
                    ForEach(0..<imageNames.count, id: \.self) { index in
                        Image(self.imageNames[index])
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 120, height: 120) // Adjust size for watchOS
                    }
                }
                .frame(height: 120) // Adjust height for watchOS
                .offset(x: CGFloat(currentIndex) * -120, y: 0) // Adjust offset for watchOS
                .animation(.easeInOut)
            }
            
            // Page control for indicating current page of slideshow
            PageControl(numberOfPages: imageNames.count, currentPage: $currentIndex)
            
            // Horizontal ScrollView for displaying image thumbnails
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 10) {
                    // Iterate over image names to display thumbnail cards
                    ForEach(0..<imageNames.count, id: \.self) { index in
                        CardView(imageName: self.imageNames[index])
                            .onTapGesture {
                                self.currentIndex = index
                            }
                    }
                }
                .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Adjust frame for watchOS
        .onAppear {
            self.startSlideshow() // Start slideshow when view appears
        }
        .onDisappear {
            self.stopSlideshow() // Stop slideshow when view disappears
        }
    }
    
    // Start automatic slideshow
    func startSlideshow() {
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
            self.currentIndex = (self.currentIndex + 1) % self.imageNames.count
        }
    }
    
    // Stop automatic slideshow
    func stopSlideshow() {
        timer?.invalidate()
        timer = nil
    }
}

// A view representing a thumbnail card
struct CardView: View {
    var imageName: String
    
    var body: some View {
        VStack {
            // Display image
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .cornerRadius(8)
            
            // Display image name as caption
            Text(imageName)
                .font(.caption)
                .padding(.top, 4)
        }
        .padding(8)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 4)
    }
}

// A view representing a page control for the slideshow
struct PageControl: View {
    var numberOfPages: Int
    @Binding var currentPage: Int
    
    var body: some View {
        HStack {
            // Display circles representing each page
            ForEach(0..<numberOfPages, id: \.self) { index in
                Circle()
                    .fill(index == self.currentPage ? Color.red : Color.gray)
                    .frame(width: 8, height: 8)
            }
        }
        .padding(.top, 8)
    }
}

// Preview for SlideshowView
struct SlideshowView_Previews: PreviewProvider {
    static var previews: some View {
        SlideshowView()
    }
}
