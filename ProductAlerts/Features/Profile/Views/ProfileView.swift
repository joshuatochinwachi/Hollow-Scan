import SwiftUI

struct ProfileView: View {
    @State private var isPremium = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Theme.background.edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Avatar Header
                        VStack(spacing: 12) {
                            ZStack(alignment: .bottomTrailing) {
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(Theme.warmGray)
                                
                                Button(action: {}) {
                                    Image(systemName: "camera.fill")
                                        .padding(8)
                                        .background(Theme.primaryAction)
                                        .foregroundColor(.white)
                                        .clipShape(Circle())
                                }
                            }
                            
                            Text("John Doe")
                                .customFont(AppFont.title2())
                            
                            Text("john@example.com")
                                .customFont(AppFont.body())
                                .foregroundColor(Theme.textPrimary.opacity(0.6))
                            
                            HStack {
                                Image(systemName: isPremium ? "crown.fill" : "star")
                                Text(isPremium ? "Premium Member" : "Free Plan")
                            }
                            .font(AppFont.caption())
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(isPremium ? Theme.profitHighlight : Theme.warmGray)
                            .cornerRadius(Spacing.CornerRadius.pill)
                        }
                        .padding(.top, 20)
                        
                        // Quick Stats
                        HStack(spacing: 16) {
                            StatCard(value: "24", label: "Saved")
                            StatCard(value: "$1.2K", label: "Profit")
                            StatCard(value: "4", label: "Alerts")
                        }
                        .padding(.horizontal)
                        
                        // Settings Sections
                        VStack(spacing: 0) {
                            SettingsGroup(title: "Account") {
                                SettingsRow(icon: "person", title: "Profile Information")
                                SettingsRow(icon: "lock", title: "Change Password")
                            }
                            
                            SettingsGroup(title: "Subscription") {
                                SettingsRow(icon: "crown", title: "Upgrade to Premium") {
                                    isPremium.toggle() // Mock upgrade
                                }
                                SettingsRow(icon: "creditcard", title: "Payment Method")
                            }
                            
                            SettingsGroup(title: "Integrations") {
                                NavigationLink(destination: TelegramLinkView()) {
                                    SettingsRowContent(icon: "paperplane.fill", title: "Link Telegram Account")
                                }
                            }
                            
                            SettingsGroup(title: "Support") {
                                SettingsRow(icon: "questionmark.circle", title: "Help & FAQ")
                                SettingsRow(icon: "envelope", title: "Contact Support")
                                SettingsRow(icon: "arrow.right.square", title: "Log Out", isDestructive: true)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 40)
                        
                        Text("Version 1.0.0 (Build 42)")
                            .font(AppFont.caption())
                            .foregroundColor(Theme.textPrimary.opacity(0.4))
                            .padding(.bottom)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct StatCard: View {
    let value: String
    let label: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text(value)
                .customFont(AppFont.title2())
                .fontWeight(.bold)
            Text(label)
                .customFont(AppFont.caption())
                .foregroundColor(Theme.textPrimary.opacity(0.6))
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(Spacing.CornerRadius.medium)
        .shadow(color: Spacing.Shadow.soft, radius: 4)
    }
}

struct SettingsGroup<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .customFont(AppFont.caption())
                .foregroundColor(Theme.textPrimary.opacity(0.6))
                .padding(.leading, 8)
                .padding(.top, 16)
            
            VStack(spacing: 0) {
                content
            }
            .background(Color.white)
            .cornerRadius(Spacing.CornerRadius.medium)
            .shadow(color: Spacing.Shadow.soft, radius: 2)
        }
    }
}

struct SettingsRow: View {
    let icon: String
    let title: String
    var isDestructive: Bool = false
    var action: (() -> Void)? = nil
    
    var body: some View {
        Button(action: { action?() }) {
            SettingsRowContent(icon: icon, title: title, isDestructive: isDestructive)
        }
    }
}

struct SettingsRowContent: View {
    let icon: String
    let title: String
    var isDestructive: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .frame(width: 24)
                .foregroundColor(isDestructive ? Theme.mutedRed : Theme.primaryAction)
            
            Text(title)
                .customFont(AppFont.body())
                .foregroundColor(isDestructive ? Theme.mutedRed : Theme.textPrimary)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(Theme.warmGray)
        }
        .padding()
        .frame(height: 50)
    }
}
