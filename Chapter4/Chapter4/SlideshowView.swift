import SwiftUI

// View representing a slideshow
struct SlideshowView: View {
    // Array of image names for the slideshow
    let imageNames = ["bromo", "bromo1", "bromo2", "bromo3"]
    // State variables to track current index and timer
    @State private var currentIndex = 0
    @State private var timer: Timer? = nil
    
    var body: some View {
        VStack {
            // Horizontal ScrollView for images
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(0..<imageNames.count, id: \.self) { index in
                        Image(self.imageNames[index])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width)
                    }
                }
                .frame(height: UIScreen.main.bounds.width * 0.75)
                .offset(x: CGFloat(currentIndex) * -UIScreen.main.bounds.width, y: 0)
                .animation(.easeInOut)
            }
            
            // Page control to indicate current image
            PageControl(numberOfPages: imageNames.count, currentPage: $currentIndex)
            
            // Horizontal ScrollView for image cards
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 10) {
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
        // Start slideshow timer when the view appears
        .onAppear {
            self.startSlideshow()
        }
        // Stop slideshow timer when the view disappears
        .onDisappear {
            self.stopSlideshow()
        }
    }
    
    // Function to start the slideshow timer
    func startSlideshow() {
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
            self.currentIndex = (self.currentIndex + 1) % self.imageNames.count
        }
    }
    
    // Function to stop the slideshow timer
    func stopSlideshow() {
        timer?.invalidate()
        timer = nil
    }
}

// View representing a card with an image and its name
struct CardView: View {
    var imageName: String
    
    var body: some View {
        VStack {
            // Image with specified width, height, and corner radius
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .cornerRadius(8)
            
            // Text displaying the image name with caption font
            Text(imageName)
                .font(.caption)
                .padding(.top, 4)
        }
        // Padding, background color, corner radius, and shadow for the card
        .padding(8)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 4)
    }
}

// Page control view to indicate current page
struct PageControl: UIViewRepresentable {
    var numberOfPages: Int // Total number of pages
    @Binding var currentPage: Int // Binding to track current page
    
    // Create the UIPageControl
    func makeUIView(context: Context) -> UIPageControl {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPageIndicatorTintColor = UIColor.red // Color for the current page indicator
        pageControl.pageIndicatorTintColor = UIColor.gray // Color for other page indicators
        return pageControl
    }
    
    // Update the UIPageControl with current page
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
}

// Preview provider for SlideshowView
struct SlideshowView_Previews: PreviewProvider {
    static var previews: some View {
        SlideshowView()
    }
}
