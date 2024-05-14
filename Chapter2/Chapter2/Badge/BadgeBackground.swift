import SwiftUI

// View representing the background of a badge
struct BadgeBackground: View {
    var body: some View {
        GeometryReader { geometry in
            // Create a path for the badge shape
            Path { path in
                // Determine width and height of the badge
                var width: CGFloat = min(geometry.size.width, geometry.size.height)
                let height = width
                
                // Define scaling and offset parameters for the hexagon shape
                let xScale: CGFloat = 0.832
                let xOffset = (width * (1.0 - xScale)) / 2.0
                width *= xScale
                
                // Move to the initial point of the path
                path.move(
                    to: CGPoint(
                        x: width * 0.95 + xOffset,
                        y: height * (0.20 + HexagonParameters.adjustment)
                    )
                )
                
                // Iterate over segments of the hexagon shape to create lines and curves
                HexagonParameters.segments.forEach { segment in
                    // Add line to the path
                    path.addLine(
                        to: CGPoint(
                            x: width * segment.line.x + xOffset,
                            y: height * segment.line.y
                        )
                    )
                    
                    // Add quadratic Bézier curve to the path
                    path.addQuadCurve(
                        to: CGPoint(
                            x: width * segment.curve.x + xOffset,
                            y: height * segment.curve.y
                        ),
                        control: CGPoint(
                            x: width * segment.control.x + xOffset,
                            y: height * segment.control.y
                        )
                    )
                }
            }
            // Fill the path with a linear gradient
            .fill(.linearGradient(
                Gradient(colors: [Self.gradientStart, Self.gradientEnd]),
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 0.6)
            ))
        }
        // Maintain aspect ratio while fitting the content
        .aspectRatio(1, contentMode: .fit)
    }
    
    // Static properties defining gradient colors for the badge background
    static let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
}

// Preview provider for BadgeBackground view
struct BadgeBackground_Previews: PreviewProvider {
    static var previews: some View {
        BadgeBackground()
    }
}
