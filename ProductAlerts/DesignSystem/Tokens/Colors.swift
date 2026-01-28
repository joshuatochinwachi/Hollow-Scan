import SwiftUI

extension Color {
    // MARK: - Primary Colors
    static let warmCream = Color(hex: "FDF6E3")
    static let softCharcoal = Color(hex: "2D3142")
    static let sunsetOrange = Color(hex: "FF8B5A")
    static let mutedTeal = Color(hex: "4ECDC4")
    static let dustyRose = Color(hex: "E8A0A0")
    
    // MARK: - Supporting Colors
    static let warmGray = Color(hex: "E8E8E8")
    static let deepPurple = Color(hex: "9B59B6")
    static let softYellow = Color(hex: "F9E79F")
    static let mutedRed = Color(hex: "E74C3C")
    
    // MARK: - Initializer for Hex
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct Theme {
    static let background = Color.warmCream
    static let textPrimary = Color.softCharcoal
    static let primaryAction = Color.sunsetOrange
    static let accent = Color.mutedTeal
    static let cardBackground = Color.white
    static let error = Color.mutedRed
    static let success = Color.mutedTeal
    static let profitHighlight = Color.softYellow
}
