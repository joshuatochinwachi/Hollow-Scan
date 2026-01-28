import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    
    let pages = [
        OnboardingPage(image: "globe.europe.africa.fill", title: "Source Sweet Deals Cheap", description: "From top stores in UK, USA & Canada:\nAmazon, Argos, Costco, Smyths & more."),
        OnboardingPage(image: "bell.badge.fill", title: "Real-Time Notifications", description: "Get instant price drop alerts with\nfull stock data and direct buy links."),
        OnboardingPage(image: "dollarsign.circle.fill", title: "Instant Profit", description: "We provide product images and\nprice history to help you flip fast.")
    ]
    
    var body: some View {
        ZStack {
            Theme.background.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                TabView(selection: $currentPage) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        OnboardingPageView(page: pages[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(height: 450)
                
                // Custom Indicators
                HStack(spacing: 8) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        Circle()
                            .fill(currentPage == index ? Theme.primaryAction : Theme.warmGray)
                            .frame(width: 8, height: 8)
                            .scaleEffect(currentPage == index ? 1.2 : 1.0)
                            .animation(.spring(), value: currentPage)
                    }
                }
                .padding(.bottom, 40)
                
                // Continue Button
                Button(action: {
                    if currentPage < pages.count - 1 {
                        withAnimation { currentPage += 1 }
                    } else {
                        // Navigate to Auth
                    }
                }) {
                    Text(currentPage == pages.count - 1 ? "Get Started" : "Continue")
                        .customFont(AppFont.headline())
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Theme.primaryAction)
                        .cornerRadius(Spacing.CornerRadius.large)
                        .shadow(color: Theme.primaryAction.opacity(0.3), radius: 8, x: 0, y: 4)
                }
                .padding(.horizontal, Spacing.large)
                .padding(.bottom, Spacing.extraLarge)
            }
        }
    }
}

struct OnboardingPage {
    let image: String
    let title: String
    let description: String
}

struct OnboardingPageView: View {
    let page: OnboardingPage
    
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: page.image) // Placeholder for Lottie
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
                .foregroundColor(Theme.primaryAction)
            
            VStack(spacing: 16) {
                Text(page.title)
                    .customFont(AppFont.title1())
                    .multilineTextAlignment(.center)
                    .foregroundColor(Theme.textPrimary)
                
                Text(page.description)
                    .customFont(AppFont.body())
                    .multilineTextAlignment(.center)
                    .foregroundColor(Theme.textPrimary.opacity(0.7))
            }
        }
        .padding()
    }
}
