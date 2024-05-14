import SwiftUI

struct SlideshowView: View {
    let imageNames = ["bromo", "bromo1", "bromo2", "bromo3"]
    @State private var currentIndex = 0
    @State private var timer: Timer? = nil
    
    var body: some View {
        VStack {
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
            
            PageControl(numberOfPages: imageNames.count, currentPage: $currentIndex)
            
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
        .onAppear {
            self.startSlideshow()
        }
        .onDisappear {
            self.stopSlideshow()
        }
    }
    
    func startSlideshow() {
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
            self.currentIndex = (self.currentIndex + 1) % self.imageNames.count
        }
    }
    
    func stopSlideshow() {
        timer?.invalidate()
        timer = nil
    }
}

struct CardView: View {
    var imageName: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .cornerRadius(8)
            
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

struct PageControl: UIViewRepresentable {
    var numberOfPages: Int
    @Binding var currentPage: Int
    
    func makeUIView(context: Context) -> UIPageControl {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPageIndicatorTintColor = UIColor.red
        pageControl.pageIndicatorTintColor = UIColor.gray
        return pageControl
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
}

struct SlideshowView_Previews: PreviewProvider {
    static var previews: some View {
        SlideshowView()
    }
}
