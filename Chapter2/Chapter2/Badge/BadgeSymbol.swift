import SwiftUI

// View representing a symbol for a badge
struct BadgeSymbol: View {
    // Static property defining the color of the symbol
    static let symbolColor = Color(red: 79.0 / 255, green: 79.0 / 255, blue: 191.0 / 255)

    var body: some View {
        GeometryReader { geometry in
            // Create a path for the badge symbol
            Path { path in
                // Define dimensions and spacing parameters
                let width = min(geometry.size.width, geometry.size.height)
                let height = width * 0.75
                let spacing = width * 0.030
                let middle = width * 0.5
                let topWidth = width * 0.226
                let topHeight = height * 0.488

                // Add lines to the path to create the shape of the badge symbol
                path.addLines([
                    CGPoint(x: middle, y: spacing),
                    CGPoint(x: middle - topWidth, y: topHeight - spacing),
                    CGPoint(x: middle, y: topHeight / 2 + spacing),
                    CGPoint(x: middle + topWidth, y: topHeight - spacing),
                    CGPoint(x: middle, y: spacing)
                ])
                
                // Move to the starting point for the lower part of the symbol
                path.move(to: CGPoint(x: middle, y: topHeight / 2 + spacing * 3))
                
                // Add lines to complete the lower part of the symbol
                path.addLines([
                    CGPoint(x: middle - topWidth, y: topHeight + spacing),
                    CGPoint(x: spacing, y: height - spacing),
                    CGPoint(x: width - spacing, y: height - spacing),
                    CGPoint(x: middle + topWidth, y: topHeight + spacing),
                    CGPoint(x: middle, y: topHeight / 2 + spacing * 3)
                ])
            }
            // Fill the path with the specified symbol color
            .fill(Self.symbolColor)
        }
    }
}

// Preview provider for BadgeSymbol view
struct BadgeSymbol_Previews: PreviewProvider {
    static var previews: some View {
        BadgeSymbol()
    }
}
