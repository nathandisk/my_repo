import SwiftUI
import MapKit

// View displaying details about a tourist attraction, including an image, description, and map view
struct ImageListView: View {
    // State variable to control the presentation of the image list
    @State private var showingImageList = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 10) {
                    // Display map view of the attraction
                    MapView(coordinate: CLLocationCoordinate2D(latitude: -7.9425, longitude: 112.9533), title: "Gunung Bromo")
                        .frame(height: 200)
                    
                    // Display circular image of the attraction
                    CircleImage(imageName: "bromo")
                    
                    // Display details about the attraction
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Bromo Mountain")
                            .font(.title)
                        Text("East Java")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Divider()
                        Text("The Bromo, or Mount Bromo is an active somma volcano and part of the Tengger mountains, in East Java, Indonesia. At 2,329 meters (7,641 ft) it is not the highest peak of the massif, but is the most active and famous.")
                        Text("The area is one of the most visited tourist destinations in East Java, and the volcano is included in the Bromo Tengger Semeru National Park. The name Bromo comes from the Javanese pronunciation of Brahma, the Hindu god of creation.")
                        Text("At the mouth of the crater, there is an idol of Ganesha, the Hindu god of wisdom which is being worshipped by the Javanese Hindus.")
                        Text("Mount Bromo is located in the middle of a plain called 'Sea of Sand' (Javanese: Segara Wedi or Indonesian: Lautan Pasir), a nature reserve that has been protected since 1919.")
                            .font(.body)
                    }
                    .padding()

                    // Button to show the image list
                    Button(action: {
                        showingImageList = true
                    }) {
                        Text("Show Image List")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical) // Add padding to the VStack to ensure it's scrollable
            }
            .navigationTitle("Bromo Mountain")
            .sheet(isPresented: $showingImageList) {
                ImageList()
            }
        }
    }
}

// View displaying a circular image
struct CircleImage: View {
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .frame(width: 200, height: 200)
            .clipShape(Circle())
            .overlay(
                Circle().stroke(Color.white, lineWidth: 4)
            )
            .shadow(radius: 7)
            .padding(.bottom, 10)
    }
}

// View representing a map view using MapKit
struct MapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D
    var title: String

    // Create and configure the map view
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        mapView.addAnnotation(annotation)
        return mapView
    }

    // Update the map view with new data
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
        uiView.setRegion(region, animated: true)
    }

    // Coordinator class to handle delegate methods
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }

        // Customize the appearance of map annotations
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            view.canShowCallout = true
            return view
        }
    }
}

// View displaying a list of images
struct ImageList: View {
    var body: some View {
        List(0..<1) { index in
            Image("bromo")
                .resizable()
                .scaledToFill()
                .frame(height: 100)
            Image("bromo1")
                .resizable()
                .scaledToFill()
                .frame(height: 100)
            Image("bromo2")
                .resizable()
                .scaledToFill()
                .frame(height: 100)
            Image("bromo3")
                .resizable()
                .scaledToFill()
                .frame(height: 100)
        }
    }
}

// Preview provider for ImageListView
struct ImageListView_Previews: PreviewProvider {
    static var previews: some View {
        ImageListView()
    }
}
