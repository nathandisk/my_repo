import SwiftUI

struct Wonder: Identifiable {
    var id = UUID()
    var name: String
    var location: String
    var imageUrl: URL?
    var isFavorite = false
}

struct ContentView: View {
    @State private var sevenWonders = [
        Wonder(name: "Great Pyramid of Giza", location: "Giza, Egypt", imageUrl: URL(string: "https://4.bp.blogspot.com/-iWyp6DacdZA/US8hOTmK96I/AAAAAAAAAs4/tmzHznlEN6I/s1600/The-Pyramids-Giza.jpg")),
        Wonder(name: "Hanging Gardens of Babylon", location: "Babylon, Iraq", imageUrl: URL(string: "https://etc.worldhistory.org/wp-content/uploads/2014/11/Figure-14.jpg")),
        Wonder(name: "Statue of Zeus at Olympia", location: "Olympia, Greece", imageUrl: URL(string: "https://www.grunge.com/img/gallery/the-untold-truth-of-the-statue-of-zeus-at-olympia/l-intro-1654683410.jpg")),
        Wonder(name: "Temple of Artemis at Ephesus", location: "Ephesus, Turkey", imageUrl: URL(string: "https://2.bp.blogspot.com/-CReMZc3j_VI/Ti1oLgFTY2I/AAAAAAAAAE8/up_pxiXl25A/s1600/ephesus.jpg")),
        Wonder(name: "Mausoleum at Halicarnassus", location: "Halicarnassus, Turkey", imageUrl: URL(string: "https://thumbs.dreamstime.com/b/ancient-city-perge-near-antalya-turkey-151823272.jpg")),
    ]

    @State private var showFavoritesOnly = false
    @State private var isListLayout = true

    var filteredWonders: [Wonder] {
        showFavoritesOnly ? sevenWonders.filter { $0.isFavorite } : sevenWonders
    }

    var body: some View {
        NavigationView {
            VStack {
                Picker("Layout", selection: $isListLayout) {
                    Text("List").tag(true)
                    Text("Card").tag(false)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                if isListLayout {
                    List {
                        wondersView
                    }
                } else {
                    ScrollView {
    LazyVGrid(columns: [GridItem(.flexible())]) {
        ForEach(filteredWonders.indices, id: \.self) { index in
            let wonder = filteredWonders[index]
            VStack(alignment: .leading) {
                AsyncImage(url: wonder.imageUrl) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                    case .failure(_):
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                    case .empty:
                        ProgressView()
                    @unknown default:
                        EmptyView()
                    }
                }
                .accessibility(label: Text("Image of \(wonder.name)"))

                Text(wonder.name)
                    .font(.headline)
                    .accessibility(label: Text("\(wonder.name)"))
                
                Text(wonder.location)
                    .font(.subheadline)
                    .accessibility(label: Text("\(wonder.location)"))

                Button(action: {
                    toggleFavorite(wonder: wonder)
                }) {
                    Image(systemName: wonder.isFavorite ? "star.fill" : "star")
                        .foregroundColor(wonder.isFavorite ? Color.orange : Color.gray)
                }
                .accessibility(label: Text(wonder.isFavorite ? "Remove from Favorites" : "Add to Favorites"))
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)

            if index != filteredWonders.count - 1 {
                Divider()
            }
        }
    }
    .padding()
}

                }
            }
            .navigationTitle("Seven Wonders")
            .navigationBarItems(trailing:
                Button(action: {
                    showFavoritesOnly.toggle()
                }) {
                    Text(showFavoritesOnly ? "Show All" : "Show Favorites Only")
                }
            )
        }
    }

    var wondersView: some View {
        ForEach(filteredWonders.indices, id: \.self) { index in
            let wonder = filteredWonders[index]
            VStack(alignment: .leading) {
                AsyncImage(url: wonder.imageUrl) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                    case .failure(_):
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                    case .empty:
                        ProgressView()
                    @unknown default:
                        EmptyView()
                    }
                }
                .accessibility(label: Text("Image of \(wonder.name)"))

                Text(wonder.name)
                    .font(.headline)
                    .accessibility(label: Text("\(wonder.name)"))
                
                Text(wonder.location)
                    .font(.subheadline)
                    .accessibility(label: Text("\(wonder.location)"))

                Button(action: {
                    toggleFavorite(wonder: wonder)
                }) {
                    Image(systemName: wonder.isFavorite ? "star.fill" : "star")
                        .foregroundColor(wonder.isFavorite ? Color.orange : Color.gray)
                }
                .accessibility(label: Text(wonder.isFavorite ? "Remove from Favorites" : "Add to Favorites"))
            }
            .padding()
        }
    }

    func toggleFavorite(wonder: Wonder) {
        if let index = sevenWonders.firstIndex(where: { $0.name == wonder.name }) {
            sevenWonders[index].isFavorite.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

