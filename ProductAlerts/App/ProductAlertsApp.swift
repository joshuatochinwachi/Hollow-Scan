import SwiftUI

// @main // Uncomment when moved to Xcode
struct ProductAlertsApp: App {
    // Simple DI implementation
    let authService = AuthService()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AppState(authService: authService))
        }
    }
}

class AppState: ObservableObject {
    @Published var currentRoute: AppRoute = .splash
    let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
}

enum AppRoute {
    case splash
    case onboarding
    case auth
    case main
}

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            switch appState.currentRoute {
            case .splash:
                SplashView()
            case .onboarding:
                OnboardingView()
            case .auth:
                SignInView()
            case .main:
                Text("Main Tab View Placeholder")
            }
        }
    }
}

// Temporary View placeholders to simulate compilation
struct SplashView: View { var body: some View { Color.warmCream } }
struct OnboardingView: View { var body: some View { Color.white } }
struct SignInView: View { var body: some View { Color.gray } }
