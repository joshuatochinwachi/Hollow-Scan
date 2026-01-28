import SwiftUI

struct PaywallView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var subManager = SubscriptionManager.shared
    @State private var selectedPlan = "annual"
    
    var body: some View {
        ZStack {
            // Background
            Theme.background.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button(action: { presentationMode.wrappedValue.dismiss() }) {
                        Image(systemName: "xmark")
                            .foregroundColor(Theme.textPrimary)
                            .padding()
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .padding()
                
                ScrollView {
                    VStack(spacing: 32) {
                        // Hero
                        VStack(spacing: 16) {
                            Image(systemName: "crown.fill") // Lottie placeholder
                                .font(.system(size: 60))
                                .foregroundColor(Theme.softYellow)
                                .shadow(color: Theme.softYellow.opacity(0.5), radius: 20)
                            
                            Text("Unlock Unlimited Deals")
                                .customFont(AppFont.largeTitle())
                                .multilineTextAlignment(.center)
                            
                            Text("Join 10,000+ successful flippers")
                                .customFont(AppFont.body())
                                .foregroundColor(Theme.textPrimary.opacity(0.7))
                        }
                        .padding(.top, 20)
                        
                        // Features
                        VStack(alignment: .leading, spacing: 16) {
                            FeatureRow(text: "Unlimited daily alerts")
                            FeatureRow(text: "Advanced profit calculator")
                            FeatureRow(text: "Priority support")
                            FeatureRow(text: "Price drop notifications")
                        }
                        .padding(.horizontal, 32)
                        
                        // Plans
                        VStack(spacing: 16) {
                            PlanOption(
                                id: "annual",
                                title: "Annual Plan - SAVE 40%",
                                price: "$8.99/month",
                                subtitle: "Billed $107.88/year",
                                isSelected: selectedPlan == "annual"
                            )
                            .onTapGesture { withAnimation { selectedPlan = "annual" } }
                            
                            PlanOption(
                                id: "monthly",
                                title: "Monthly Plan",
                                price: "$14.99/month",
                                subtitle: "Billed monthly",
                                isSelected: selectedPlan == "monthly"
                            )
                            .onTapGesture { withAnimation { selectedPlan = "monthly" } }
                        }
                        .padding(.horizontal)
                        
                        // CTA
                        Button(action: {
                            // Purchase logic
                        }) {
                            VStack(spacing: 4) {
                                Text("Start Free 7-Day Trial")
                                    .customFont(AppFont.headline())
                                Text("Then $8.99/month")
                                    .customFont(AppFont.caption())
                                    .opacity(0.9)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .frame(height: 60)
                            .background(
                                LinearGradient(colors: [Theme.primaryAction, Theme.deepPurple], startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(Spacing.CornerRadius.large)
                            .shadow(color: Theme.primaryAction.opacity(0.4), radius: 10, x: 0, y: 5)
                            .scaleEffect(1.0) // Add pulse animation here
                        }
                        .padding(.horizontal)
                        
                        Text("Cancel anytime • Secure payment")
                            .customFont(AppFont.caption())
                            .foregroundColor(Theme.textPrimary.opacity(0.5))
                            .padding(.bottom)
                        
                        Button("Restore Purchase") { subManager.restorePurchases() }
                            .customFont(AppFont.caption())
                            .foregroundColor(Theme.textPrimary)
                    }
                }
            }
        }
    }
}

struct FeatureRow: View {
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(Theme.success)
            Text(text)
                .customFont(AppFont.body())
            Spacer()
        }
    }
}

struct PlanOption: View {
    let id: String
    let title: String
    let price: String
    let subtitle: String
    let isSelected: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .customFont(AppFont.headline())
                    .foregroundColor(isSelected ? Theme.primaryAction : Theme.textPrimary)
                Text(price)
                    .customFont(AppFont.title2())
                Text(subtitle)
                    .customFont(AppFont.caption())
                    .foregroundColor(Theme.textPrimary.opacity(0.6))
            }
            Spacer()
            
            Image(systemName: isSelected ? "circle.inset.filled" : "circle")
                .font(.title2)
                .foregroundColor(isSelected ? Theme.primaryAction : Theme.warmGray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(Spacing.CornerRadius.medium)
        .overlay(
            RoundedRectangle(cornerRadius: Spacing.CornerRadius.medium)
                .stroke(isSelected ? Theme.primaryAction : Color.clear, lineWidth: 2)
        )
        .shadow(color: Spacing.Shadow.soft, radius: 4)
    }
}
