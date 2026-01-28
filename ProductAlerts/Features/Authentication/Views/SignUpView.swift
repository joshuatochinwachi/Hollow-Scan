import SwiftUI

struct SignUpView: View {
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    @EnvironmentObject var appState: AppState // Access global state
    
    var body: some View {
        ZStack {
            Theme.background.edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 32) {
                    // Header
                    VStack(spacing: 12) {
                        Image(systemName: "person.2.circle") // Placeholder
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .foregroundColor(Theme.primaryAction)
                        
                        Text("Create Your Account")
                            .customFont(AppFont.title1())
                            .foregroundColor(Theme.textPrimary)
                        
                        Text("Join thousands of savvy flippers")
                            .customFont(AppFont.body())
                            .foregroundColor(Theme.textPrimary.opacity(0.6))
                    }
                    .padding(.top, 60)
                    
                    // Form
                    VStack(spacing: 20) {
                        CustomTextField(icon: "person", placeholder: "Name (optional)", text: $fullName)
                        
                        CustomTextField(icon: "envelope", placeholder: "Email", text: $email)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                        
                        CustomTextField(icon: "lock", placeholder: "Password", text: $password, isSecure: true)
                        
                        // Password Strength Indicator (Simplified)
                        if !password.isEmpty {
                            HStack {
                                ForEach(0..<4) { index in
                                    Rectangle()
                                        .fill(index < password.count / 3 ? Theme.success : Theme.warmGray)
                                        .frame(height: 4)
                                        .cornerRadius(2)
                                }
                                Text(password.count > 8 ? "Strong" : "Weak")
                                    .customFont(AppFont.caption())
                            }
                        }
                    }
                    .padding(.horizontal, Spacing.large)
                    
                    // Main Action
                    Button(action: signUp) {
                        HStack {
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            } else {
                                Text("Create Account")
                                    .customFont(AppFont.headline())
                                Image(systemName: "arrow.right")
                            }
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Theme.primaryAction, Theme.dustyRose]), startPoint: .leading, endPoint: .trailing)
                        )
                        .cornerRadius(Spacing.CornerRadius.large)
                        .shadow(color: Theme.primaryAction.opacity(0.3), radius: 8, x: 0, y: 4)
                    }
                    .padding(.horizontal, Spacing.large)
                    
                    // Footer
                    VStack(spacing: 16) {
                        HStack {
                            Rectangle().fill(Theme.warmGray).frame(height: 1)
                            Text("OR").customFont(AppFont.caption()).foregroundColor(Theme.warmGray)
                            Rectangle().fill(Theme.warmGray).frame(height: 1)
                        }
                        
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "applelogo")
                                Text("Continue with Apple")
                                    .customFont(AppFont.headline())
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(Spacing.CornerRadius.large)
                        }
                        
                        Button("Already have an account? Sign In") {
                             // Navigate back
                        }
                        .customFont(AppFont.subheadline())
                        .foregroundColor(Theme.primaryAction)
                    }
                    .padding(.horizontal, Spacing.large)
                }
                .padding(.bottom, 40)
            }
        }
    }
    
    func signUp() {
        isLoading = true
        // Simulate Network Request
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isLoading = false
            // Navigate to Verification
        }
    }
}
