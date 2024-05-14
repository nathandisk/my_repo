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
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 120, height: 120) // Adjust size for watchOS
                    }
                }
                .frame(height: 120) // Adjust height for watchOS
                .offset(x: CGFloat(currentIndex) * -120, y: 0) // Adjust offset for watchOS
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
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Adjust frame for watchOS
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
                .frame(width: 50, height: 50)
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

struct PageControl: View {
    var numberOfPages: Int
    @Binding var currentPage: Int
    
    var body: some View {
        HStack {
            ForEach(0..<numberOfPages, id: \.self) { index in
                Circle()
                    .fill(index == self.currentPage ? Color.red : Color.gray)
                    .frame(width: 8, height: 8)
            }
        }
        .padding(.top, 8)
    }
}

struct SlideshowView_Previews: PreviewProvider {
    static var previews: some View {
        SlideshowView()
    }
}
