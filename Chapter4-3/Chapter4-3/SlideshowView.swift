import SwiftUI // Importing the SwiftUI framework

struct SlideshowView: View { // Defining a SwiftUI view called SlideshowView
    // Array of image names
    let imageNames = ["bromo", "bromo1", "bromo2", "bromo3"]
    // State variables to track current index and timer for slideshow
    @State private var currentIndex = 0
    @State private var timer: Timer? = nil
    
    var body: some View { // Declaring the body of the SlideshowView
        VStack { // Vertical stack to organize the content
            ScrollView(.horizontal, showsIndicators: false) { // Horizontal scroll view for the images
                LazyHStack(spacing: 0) { // Lazy horizontal stack to display images
                    ForEach(0..<imageNames.count, id: \.self) { index in // Loop through image names
                        Image(self.imageNames[index]) // Displaying the image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 500, height: 400) // Adjust size for macOS
                    }
                }
                .frame(height: 400) // Adjust height for macOS
                .offset(x: CGFloat(currentIndex) * -500, y: 0) // Adjust offset for macOS
                .animation(.easeInOut) // Animation for smooth transition
            }
            
            PageControl(numberOfPages: imageNames.count, currentPage: $currentIndex) // Displaying page control
            
            ScrollView(.horizontal, showsIndicators: false) { // Horizontal scroll view for cards
                LazyHStack(spacing: 10) { // Lazy horizontal stack for cards
                    ForEach(0..<imageNames.count, id: \.self) { index in // Loop through image names
                        CardView(imageName: self.imageNames[index]) // Displaying card view for each image
                            .onTapGesture { // Handling tap gesture to change current index
                                self.currentIndex = index
                            }
                    }
                }
                .padding() // Adding padding
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Adjust frame for macOS
        .onAppear { // Executed when the view appears
            self.startSlideshow() // Start the slideshow
        }
        .onDisappear { // Executed when the view disappears
            self.stopSlideshow() // Stop the slideshow
        }
    }
    
    // Function to start the slideshow
    func startSlideshow() {
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in // Schedule a timer
            self.currentIndex = (self.currentIndex + 1) % self.imageNames.count // Increment current index
        }
    }
    
    // Function to stop the slideshow
    func stopSlideshow() {
        timer?.invalidate() // Invalidate the timer
        timer = nil // Reset the timer
    }
}

struct CardView: View { // Defining a card view
    var imageName: String // Image name
    
    var body: some View { // Declaring the body of the card view
        VStack { // Vertical stack to organize the content
            Image(imageName) // Displaying the image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100) // Set image size
                .cornerRadius(8) // Apply corner radius
            
            Text(imageName) // Displaying the image name
                .font(.caption) // Setting font size
                .padding(.top, 4) // Adding top padding
        }
        .padding(8) // Adding padding
        .background(Color.white) // Setting background color
        .cornerRadius(10) // Apply corner radius
        .shadow(radius: 4) // Adding shadow
    }
}

struct PageControl: View { // Defining a page control view
    var numberOfPages: Int // Total number of pages
    @Binding var currentPage: Int // Current page
    
    var body: some View { // Declaring the body of the page control
        HStack { // Horizontal stack to organize circles
            ForEach(0..<numberOfPages, id: \.self) { index in // Loop through pages
                Circle() // Displaying a circle
                    .fill(index == self.currentPage ? Color.red : Color.gray) // Setting fill color based on current page
                    .frame(width: 8, height: 8) // Setting circle size
            }
        }
        .padding(.top, 8) // Adding top padding
    }
}

struct SlideshowView_Previews: PreviewProvider { // Preview provider for SlideshowView
    static var previews: some View { // Declaring a preview for SlideshowView
        SlideshowView() // Displaying a preview of SlideshowView
    }
}
