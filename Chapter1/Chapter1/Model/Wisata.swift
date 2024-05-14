import Foundation
import SwiftUI
import CoreLocation

// Structure representing a tourist attraction
struct Wisata: Hashable, Codable {
    var id: Int // Unique identifier
    var name: String // Name of the attraction
    var park: String // Park associated with the attraction
    var state: String // State where the attraction is located
    var description: String // Description of the attraction


    private var imageName: String // Name of the image file associated with the attraction
    var image: Image { // Computed property to load the image
        Image(imageName)
    }


    private var coordinates: Coordinates // Coordinates of the attraction
    var locationCoordinate: CLLocationCoordinate2D { // Computed property to convert coordinates to CLLocationCoordinate2D
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }


    // Structure representing coordinates
    struct Coordinates: Hashable, Codable {
        var latitude: Double // Latitude coordinate
        var longitude: Double // Longitude coordinate
    }
}
