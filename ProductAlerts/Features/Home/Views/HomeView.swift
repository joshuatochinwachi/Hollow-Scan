import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var showFilterSheet = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Theme.background.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        Image(systemName: "bell.badge.fill") // Icon
                            .foregroundColor(Theme.primaryAction)
                        
                        Text("HollowScan")
                            .customFont(AppFont.title2())
                        
                        Spacer()
                        
                        // Alerts Counter Component
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .font(.caption)
                            Text("2/4")
                                .font(.caption).bold()
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Theme.profitHighlight)
                        .cornerRadius(Spacing.CornerRadius.pill)
                        
                        NavigationLink(destination: Text("Profile")) { // Placeholder for Profile
                            Image(systemName: "person.crop.circle")
                                .font(.title2)
                                .foregroundColor(Theme.textPrimary)
                        }
                    }
                    .padding()
                    
                    // Country Tabs
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(["US", "UK", "DE", "EU"], id: \.self) { country in
                                VStack(spacing: 4) {
                                    Text(country)
                                        .customFont(AppFont.headline())
                                        .foregroundColor(viewModel.selectedCountry == country ? Theme.textPrimary : Theme.textPrimary.opacity(0.5))
                                    
                                    if viewModel.selectedCountry == country {
                                        Rectangle()
                                            .fill(Theme.primaryAction)
                                            .frame(height: 2)
                                            .matchedGeometryEffect(id: "tab", in: Namespace().wrappedValue)
                                    } else {
                                        Rectangle().fill(Color.clear).frame(height: 2)
                                    }
                                }
                                .onTapGesture {
                                    withAnimation { viewModel.selectedCountry = country }
                                    viewModel.refresh()
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 8)
                    
                    // Filter Bar
                    HStack {
                        Button(action: { showFilterSheet.toggle() }) {
                            HStack {
                                Text(viewModel.selectedCategory?.name ?? "All Products")
                                Image(systemName: "chevron.down")
                            }
                            .font(AppFont.subheadline())
                            .foregroundColor(Theme.textPrimary)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.white)
                            .cornerRadius(Spacing.CornerRadius.pill)
                            .shadow(color: Spacing.Shadow.soft, radius: 4)
                        }
                        
                        Spacer()
                        
                        Button(action: {}) {
                            HStack {
                                Text("Sort")
                                Image(systemName: "arrow.up.arrow.down")
                            }
                            .font(AppFont.subheadline())
                            .foregroundColor(Theme.textPrimary)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    
                    // Product List
                    if viewModel.isLoading {
                        Spacer()
                        ProgressView()
                        Spacer()
                    } else if viewModel.products.isEmpty {
                        Spacer()
                        VStack(spacing: 16) {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 40))
                                .foregroundColor(Theme.warmGray)
                            Text("No deals found")
                                .customFont(AppFont.body())
                                .foregroundColor(Theme.textPrimary.opacity(0.6))
                        }
                        Spacer()
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 16) {
                                // Quick Stats Card
                                QuickStatsCard()
                                    .padding(.horizontal)
                                
                                ForEach(viewModel.products) { product in
                                    NavigationLink(destination: Text("Detail for \(product.title)")) {
                                        ProductCard(product: product) {
                                            viewModel.toggleSave(product)
                                        }
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .padding(.horizontal)
                                }
                            }
                            .padding(.top, 8)
                            .padding(.bottom, 20)
                        }
                        .refreshable { // Pull to refresh
                            viewModel.refresh()
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// Subcomponent: Quick Stats
struct QuickStatsCard: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                 Text("💰 Today's Best")
                    .font(AppFont.caption())
                 Text("+67% Profit")
                    .font(AppFont.headline())
                    .foregroundColor(Theme.success)
            }
            Spacer()
            VStack(alignment: .leading) {
                 Text("📈 New Deals")
                    .font(AppFont.caption())
                 Text("24 in last hour")
                    .font(AppFont.headline())
            }
        }
        .padding()
        .background(Theme.cardBackground)
        .cornerRadius(Spacing.CornerRadius.medium)
        .shadow(color: Spacing.Shadow.soft, radius: 4)
    }
}
