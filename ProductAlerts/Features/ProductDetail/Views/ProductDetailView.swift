import SwiftUI

struct ProductDetailView: View {
    let product: ProductModel
    @Environment(\.presentationMode) var presentationMode
    @State private var isSaved: Bool
    
    init(product: ProductModel) {
        self.product = product
        _isSaved = State(initialValue: product.isSaved)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Theme.background.edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 0) {
                    // Image Gallery
                    ImageGalleryView(images: [product.imageUrl])
                    
                    VStack(spacing: 24) {
                        // Title Header
                        VStack(alignment: .leading, spacing: 8) {
                            Text(product.title)
                                .customFont(AppFont.title2())
                                .foregroundColor(Theme.textPrimary)
                            
                            HStack {
                                Text(product.category.name)
                                    .font(AppFont.caption())
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Theme.warmGray)
                                    .cornerRadius(Spacing.CornerRadius.small)
                                
                                Text(timeAgo(date: product.postedAt))
                                    .font(AppFont.caption())
                                    .foregroundColor(Theme.textPrimary.opacity(0.5))
                            }
                        }
                        
                        // Profit Calculator
                        ProfitCalculatorView(buy: product.currentPrice, sell: product.targetResellPrice)
                        
                        // Research Tools
                        VStack(alignment: .leading, spacing: 16) {
                            Text("📊 Research This Product")
                                .customFont(AppFont.headline())
                            
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                                ResearchButton(title: "eBay Sold", icon: "cart")
                                ResearchButton(title: "Amazon History", icon: "chart.line.uptrend.xyaxis")
                                ResearchButton(title: "Google Trends", icon: "magnifyingglass")
                                ResearchButton(title: "Keepa", icon: "chart.bar")
                            }
                        }
                        
                        // Purchase Links
                        VStack(alignment: .leading, spacing: 16) {
                            Text("🛒 Where to Buy")
                                .customFont(AppFont.headline())
                            
                            PurchaseLinkRow(store: product.source, price: product.currentPrice)
                        }
                        
                        // Description
                        VStack(alignment: .leading, spacing: 8) {
                            Text("📝 Description")
                                .customFont(AppFont.headline())
                            Text(product.description)
                                .customFont(AppFont.body())
                                .foregroundColor(Theme.textPrimary.opacity(0.8))
                                .lineSpacing(4)
                        }
                        
                        Spacer(minLength: 100)
                    }
                    .padding()
                }
            }
            
            // Sticky Bottom Bar
            VStack {
                Spacer()
                HStack(spacing: 16) {
                    Button(action: { isSaved.toggle() }) {
                        HStack {
                            Image(systemName: isSaved ? "heart.fill" : "heart")
                            Text(isSaved ? "Saved" : "Save")
                        }
                        .font(AppFont.headline())
                        .foregroundColor(isSaved ? Theme.mutedRed : Theme.textPrimary)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(Spacing.CornerRadius.large)
                        .shadow(color: Spacing.Shadow.soft, radius: 4)
                    }
                    
                    Button(action: { /* Open Link */ }) {
                        Text("View Sources")
                            .font(AppFont.headline())
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Theme.primaryAction)
                            .cornerRadius(Spacing.CornerRadius.large)
                            .shadow(color: Theme.primaryAction.opacity(0.3), radius: 8)
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Helper helper for time
    func timeAgo(date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}

struct ResearchButton: View {
    let title: String
    let icon: String
    
    var body: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: icon)
                Text(title)
                    .font(AppFont.caption())
            }
            .foregroundColor(Theme.textPrimary)
            .frame(maxWidth: .infinity)
            .padding(12)
            .background(Color.white)
            .cornerRadius(Spacing.CornerRadius.medium)
            .overlay(
                RoundedRectangle(cornerRadius: Spacing.CornerRadius.medium)
                    .stroke(Theme.warmGray, lineWidth: 1)
            )
        }
    }
}

struct PurchaseLinkRow: View {
    let store: String
    let price: Double
    
    var body: some View {
        HStack {
            Image(systemName: "bag.fill")
                .foregroundColor(Theme.textPrimary)
                .padding(8)
                .background(Theme.warmGray)
                .clipShape(Circle())
            
            Text(store)
                .font(AppFont.subheadline())
            
            Spacer()
            
            Text("$\(String(format: "%.2f", price))")
                .font(AppFont.headline())
            
            Image(systemName: "arrow.up.forward.square")
                .foregroundColor(Theme.textPrimary.opacity(0.5))
        }
        .padding()
        .background(Color.white)
        .cornerRadius(Spacing.CornerRadius.medium)
    }
}
