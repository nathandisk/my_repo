import SwiftUI

struct ContentView: View {
    @State private var selectedCategory = "Swift"
    let categories = ["Swift", "iOS", "macOS", "watchOS"]

    var body: some View {
        VStack {
            Picker("Select a Category", selection: $selectedCategory) {
                ForEach(categories, id: \.self) { category in
                    Text(category)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            if let categoryIndex = categories.firstIndex(of: selectedCategory) {
                CategoryCard(category: categories[categoryIndex])
                    .padding()
            }
        }
        .padding()
    }
}

struct CategoryCard: View {
    var category: String

    var body: some View {
        VStack {
            Text("Selected Category:")
                .font(.title)
            Text(category)
                .font(.headline)
                .padding()
            Image(systemName: "square.stack.3d.up.fill")
                .font(.largeTitle)
                .foregroundColor(.blue)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
