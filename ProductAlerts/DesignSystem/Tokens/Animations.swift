import SwiftUI

struct AppAnimations {
    // Cozy, bouncy springs for that "Lo-Fi" feel
    
    static let gentleSpring = Animation.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0)
    static let bouncySpring = Animation.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)
    static let snappySpring = Animation.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0)
    
    // Sluggish/Calm for background elements
    static let slowFade = Animation.easeIn(duration: 0.5)
}

extension View {
    func shimmer() -> some View {
        self.modifier(ShimmerEffect())
    }
}

struct ShimmerEffect: ViewModifier {
    @State private var phase: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geo in
                    Rectangle()
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color.clear, Color.white.opacity(0.4), Color.clear]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .frame(width: geo.size.width * 1.5)
                        .offset(x: phase * geo.size.width * 2 - geo.size.width)
                }
            )
            .mask(content)
            .onAppear {
                withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                    phase = 1
                }
            }
    }
}
