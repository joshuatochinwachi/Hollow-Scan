import SwiftUI

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    
    var body: some View {
        ZStack {
            Theme.background.edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 32) {
                    // Header
                    VStack(spacing: 12) {
                        Image(systemName: "person.crop.circle.badge.checkmark") // Placeholder
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .foregroundColor(Theme.primaryAction)
                        
                        Text("Welcome Back!")
                            .customFont(AppFont.title1())
                            .foregroundColor(Theme.textPrimary)
                        
                        Text("Let's find you some deals")
                            .customFont(AppFont.body())
                            .foregroundColor(Theme.textPrimary.opacity(0.6))
                    }
                    .padding(.top, 60)
                    
                    // Form
                    VStack(spacing: 20) {
                        CustomTextField(icon: "envelope", placeholder: "Email", text: $email)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                        
                        CustomTextField(icon: "lock", placeholder: "Password", text: $password, isSecure: true)
                        
                        Button("Forgot Password?") { }
                            .customFont(AppFont.footnote())
                            .foregroundColor(Theme.textPrimary.opacity(0.6))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding(.horizontal, Spacing.large)
                    
                    // Main Action
                    Button(action: signIn) {
                        HStack {
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            } else {
                                Text("Sign In")
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
                    
                    // Divider
                    HStack {
                        Rectangle().fill(Theme.warmGray).frame(height: 1)
                        Text("OR").customFont(AppFont.caption()).foregroundColor(Theme.warmGray)
                        Rectangle().fill(Theme.warmGray).frame(height: 1)
                    }
                    .padding(.horizontal, Spacing.large)
                    
                    // Apple Sign In
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "applelogo")
                            Text("Sign in with Apple")
                                .customFont(AppFont.headline())
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(Spacing.CornerRadius.large)
                    }
                    .padding(.horizontal, Spacing.large)
                }
            }
        }
    }
    
    func signIn() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isLoading = false
            // Complete sign in
        }
    }
}

struct CustomTextField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(Theme.textPrimary.opacity(0.4))
            
            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(Spacing.CornerRadius.medium)
        .overlay(
            RoundedRectangle(cornerRadius: Spacing.CornerRadius.medium)
                .stroke(Theme.warmGray, lineWidth: 1)
        )
    }
}
