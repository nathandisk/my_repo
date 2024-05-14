import Foundation

// Function to load a decodable object from a file
func load<T: Decodable>(_ filename: String) -> T {
    // Variable to hold file data
    let data: Data

    // Check if the file exists in the main bundle
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        // If file not found, raise a fatal error
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        // Attempt to read file data
        data = try Data(contentsOf: file)
    } catch {
        // If reading fails, raise a fatal error
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        // Attempt to decode the data into the specified type
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        // If decoding fails, raise a fatal error
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
