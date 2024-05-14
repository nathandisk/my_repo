import SwiftUI

// View representing a badge
struct Badge: View {
    // Computed property to generate badge symbols
    var badgeSymbols: some View {
        ForEach(0..<8) { index in
            RotatedBadgeSymbol(
                angle: .degrees(Double(index) / Double(8)) * 180.0
            )
        }
        .opacity(0.5)
    }
    
    var body: some View {
        ZStack {
            // Background of the badge
            BadgeBackground()
            
            GeometryReader { geometry in
                // Position and scale badge symbols relative to geometry
                badgeSymbols
                    .scaleEffect(1.0 / 4.0, anchor: .top)
                    .position(x: geometry.size.width / 2.0, y: (3.0 / 4.0) * geometry.size.height)
            }
        }
        .scaledToFit()
    }
}

// Preview provider for Badge view
struct Badge_Previews: PreviewProvider {
    static var previews: some View {
        Badge()
    }
}
