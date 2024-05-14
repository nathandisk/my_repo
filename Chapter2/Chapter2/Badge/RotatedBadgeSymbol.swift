import SwiftUI

// View representing a rotated badge symbol
struct RotatedBadgeSymbol: View {
    let angle: Angle // Angle of rotation
    
    var body: some View {
        // Display the badge symbol, rotated by the specified angle
        BadgeSymbol()
            .padding(-60) // Apply negative padding to adjust the position of the symbol
            .rotationEffect(angle, anchor: .bottom) // Rotate the symbol around its bottom anchor point
    }
}

// Preview provider for RotatedBadgeSymbol view
struct RotatedBageSymbol_Previews: PreviewProvider {
    static var previews: some View {
        RotatedBadgeSymbol(angle: Angle(degrees: 5)) // Preview a rotated badge symbol with a 5-degree angle
    }
}
