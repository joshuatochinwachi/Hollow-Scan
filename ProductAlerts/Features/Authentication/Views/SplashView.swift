import SwiftUI

struct SplashView: View {
    @State private var scale: CGFloat = 0.8
    @State private var opacity: Double = 0
    @State private var gradientStart = UnitPoint.topLeading
    @State private var gradientEnd = UnitPoint.bottomTrailing
    
    var body: some View {
        ZStack {
            // Animated gradient background
            LinearGradient(gradient: Gradient(colors: [
                Color.sunsetOrange,
                Color.dustyRose,
                Color.deepPurple
            ]), startPoint: gradientStart, endPoint: gradientEnd)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                withAnimation(Animation.linear(duration: 3.0).repeatForever(autoreverses: true)) {
                    self.gradientStart = .bottomLeading
                    self.gradientEnd = .topTrailing
                }
            }
            
            VStack(spacing: 24) {
                // App icon placeholder
                Image(systemName: "bell.badge.fill") // Placeholder for AppIcon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .foregroundColor(.white)
                    .scaleEffect(scale)
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                
                // App name + tagline
                VStack(spacing: 8) {
                    Text("HollowScan")
                        .customFont(AppFont.largeTitle())
                        .foregroundColor(.white)
                    
                    Text("Find. Flip. Profit.")
                        .customFont(AppFont.title2())
                        .foregroundColor(.white.opacity(0.9))
                        .opacity(opacity)
                }
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                scale = 1.0
            }
            withAnimation(.easeIn(duration: 0.5).delay(0.3)) {
                opacity = 1.0
            }
            
            // Navigate after delay (Simulated)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                // In a real app, this would trigger the AppState to change route
                // For now, it's just visual
            }
        }
    }
}
