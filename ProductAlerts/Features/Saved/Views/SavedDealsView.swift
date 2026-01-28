import SwiftUI

struct SavedDealsView: View {
    @StateObject private var viewModel = SavedViewModel()
    @State private var isGridView = false
    
    // Grid Layout
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Theme.background.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    // Header Stats
                    VStack(spacing: 8) {
                        Text("Saved Deals")
                            .customFont(AppFont.title2())
                        
                        Text("\(viewModel.savedProducts.count) saved • $\(String(format: "%.0f", viewModel.totalPotentialProfit)) total profit")
                            .customFont(AppFont.caption())
                            .foregroundColor(Theme.textPrimary.opacity(0.6))
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Theme.background)
                    
                    // Controls
                    HStack {
                        Button(action: { /* Filter */ }) {
                            HStack {
                                Text("Newest First")
                                Image(systemName: "chevron.down")
                            }
                            .font(AppFont.subheadline())
                            .foregroundColor(Theme.textPrimary)
                        }
                        
                        Spacer()
                        
                        Picker("View Mode", selection: $isGridView) {
                            Image(systemName: "rectangle.grid.1x2").tag(false)
                            Image(systemName: "square.grid.2x2").tag(true)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 100)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                    
                    // List
                    if viewModel.savedProducts.isEmpty {
                        EmptyStateView()
                    } else {
                        ScrollView {
                            if isGridView {
                                LazyVGrid(columns: columns, spacing: 16) {
                                    ForEach(viewModel.savedProducts) { product in
                                        CompactProductCard(product: product)
                                    }
                                }
                                .padding()
                            } else {
                                LazyVStack(spacing: 16) {
                                    ForEach(viewModel.savedProducts) { product in
                                        ProductCard(product: product) {
                                            viewModel.remove(product)
                                        }
                                    }
                                }
                                .padding()
                            }
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

class SavedViewModel: ObservableObject {
    @Published var savedProducts: [ProductModel] = []
    
    var totalPotentialProfit: Double {
        savedProducts.reduce(0) { $0 + $1.profitAmount }
    }
    
    init() {
        // Mock data
        savedProducts = [ProductModel.mock()]
    }
    
    func remove(_ product: ProductModel) {
        // Remove logic
        if let index = savedProducts.firstIndex(where: { $0.id == product.id }) {
            savedProducts.remove(at: index)
        }
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(systemName: "heart.slash")
                .font(.system(size: 60))
                .foregroundColor(Theme.warmGray)
            Text("No Saved Deals Yet")
                .customFont(AppFont.title2())
            Text("Tap the ♡ on any product\nto save it for later!")
                .customFont(AppFont.body())
                .multilineTextAlignment(.center)
                .foregroundColor(Theme.textPrimary.opacity(0.6))
            Spacer()
        }
    }
}

struct CompactProductCard: View {
    let product: ProductModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Rectangle()
                .fill(Theme.warmGray.opacity(0.3))
                .aspectRatio(1, contentMode: .fit)
                .overlay(Image(systemName: "photo").foregroundColor(Theme.textPrimary.opacity(0.2)))
                .cornerRadius(Spacing.CornerRadius.medium, corners: [.topLeft, .topRight])
            
            VStack(alignment: .leading, spacing: 4) {
                Text(product.title)
                    .font(AppFont.caption())
                    .lineLimit(2)
                
                Text("+\(product.profitPercentage)%")
                    .font(AppFont.caption())
                    .fontWeight(.bold)
                    .foregroundColor(Theme.success)
            }
            .padding(8)
        }
        .background(Color.white)
        .cornerRadius(Spacing.CornerRadius.medium)
        .shadow(color: Spacing.Shadow.soft, radius: 2)
    }
}
