import SwiftUI

struct AppFont {
    // Using System Fonts as fallback or custom if verified available.
    // For this prompt "SF Pro Rounded" is requested.
    // In SwiftUI, .design(.rounded) on system fonts achieves this.
    
    static func largeTitle() -> Font {
        return .system(size: 34, weight: .bold, design: .rounded)
    }
    
    static func title1() -> Font {
        return .system(size: 28, weight: .semibold, design: .rounded)
    }
    
    static func title2() -> Font {
        return .system(size: 22, weight: .semibold, design: .rounded)
    }
    
    static func headline() -> Font {
        return .system(size: 17, weight: .semibold, design: .rounded)
    }
    
    static func body() -> Font {
        return .system(size: 17, weight: .regular, design: .default)
    }
    
    static func callout() -> Font {
        return .system(size: 16, weight: .regular, design: .default)
    }
    
    static func subheadline() -> Font {
        return .system(size: 15, weight: .regular, design: .default)
    }
    
    static func footnote() -> Font {
        return .system(size: 13, weight: .regular, design: .default)
    }
    
    static func caption() -> Font {
        return .system(size: 12, weight: .regular, design: .default)
    }
    
    // For numbers/prices
    static func number(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        return .system(size: size, weight: weight, design: .monospaced)
    }
}

// View Modifier for easy application
extension View {
    func customFont(_ style: Font) -> some View {
        self.font(style)
    }
}
