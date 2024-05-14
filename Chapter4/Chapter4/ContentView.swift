import SwiftUI

// Main content view
struct ContentView: View {
    // State variable to track the selected category
    @State private var selectedCategory = "Swift"
    // Array of categories
    let categories = ["Swift", "iOS", "macOS", "watchOS"]

    var body: some View {
        VStack {
            // Picker to select a category
            Picker("Select a Category", selection: $selectedCategory) {
                ForEach(categories, id: \.self) { category in
                    Text(category)
                }
            }
            .pickerStyle(SegmentedPickerStyle()) // Apply segmented picker style
            
            // Display category card based on the selected category
            if let categoryIndex = categories.firstIndex(of: selectedCategory) {
                CategoryCard(category: categories[categoryIndex])
                    .padding()
            }
        }
        .padding()
    }
}

// View representing a category card
struct CategoryCard: View {
    var category: String // Category name

    var body: some View {
        VStack {
            // Display selected category title
            Text("Selected Category:")
                .font(.title)
            // Display selected category
            Text(category)
                .font(.headline)
                .padding()
            // Display an image indicating category (placeholder)
            Image(systemName: "square.stack.3d.up.fill")
                .font(.largeTitle)
                .foregroundColor(.blue)
        }
        .padding()
        .background(Color.gray.opacity(0.1)) // Apply background color with opacity
        .cornerRadius(10) // Apply corner radius
    }
}

// Preview provider for ContentView
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
