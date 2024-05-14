//
//  CategoryHome.swift
//  Chapter4
//
//  Created by Adi Soetrisno on 2024/05/03.
//

import SwiftUI

struct Landmark: Identifiable {
    var id: Int
    var name: String
    var category: String
}

struct FeatureCard: View {
    var landmark: Landmark

    var body: some View {
        Text(landmark.name)
    }
}

struct CategoryRow: View {
    var categoryName: String
    var items: [Landmark]

    var body: some View {
        Text(categoryName)
    }
}

struct ModelData {
    var features: [Landmark] = []
    var categories: [String: [Landmark]] = [:]
}

struct NavigationSplitView<Master: View, Detail: View>: View {
    var master: Master
    var detail: Detail

    var body: some View {
        HStack {
            master
            detail
        }
    }
}

struct ProfileHost: View {
    var body: some View {
        Text("User Profile")
    }
}

struct CategoryHome: View {
    @Environment(ModelData.self) var modelData
    @State private var showingProfile = false


    var body: some View {
        NavigationSplitView {
            List {
                PageView(pages: modelData.features.map { FeatureCard(landmark: $0) })
                    .listRowInsets(EdgeInsets())


                ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                    CategoryRow(categoryName: key, items: modelData.categories[key]!)
                }
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.inset)
            .navigationTitle("Featured")
            .toolbar {
                Button {
                    showingProfile.toggle()
                } label: {
                    Label("User Profile", systemImage: "person.crop.circle")
                }
            }
            .sheet(isPresented: $showingProfile) {
                ProfileHost()
                    .environment(modelData)
            }
        } detail: {
            Text("Select a Landmark")
        }
    }
}


struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
            .environment(ModelData())
    }
}
