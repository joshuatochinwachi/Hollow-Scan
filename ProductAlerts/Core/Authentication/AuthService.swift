import Foundation
import Combine

enum AuthState {
    case unauthenticated
    case authenticated
    case verifyingEmail
}

protocol AuthServiceProtocol {
    var authState: CurrentValueSubject<AuthState, Never> { get }
    func signIn(email: String, password: String) async throws
    func signUp(email: String, password: String) async throws
    func signOut()
}

class AuthService: AuthServiceProtocol {
    private let supabase = AppSupabaseClient.shared
    
    var authState = CurrentValueSubject<AuthState, Never>(.unauthenticated)
    
    func signIn(email: String, password: String) async throws {
        // try await supabase.signIn(email: email, password: password)
        // Check verification status...
        authState.send(.authenticated)
    }
    
    func signUp(email: String, password: String) async throws {
        // try await supabase.signUp(email: email, password: password)
        authState.send(.verifyingEmail)
    }
    
    func signOut() {
        Task {
            // try? await supabase.signOut()
            authState.send(.unauthenticated)
        }
    }
}
