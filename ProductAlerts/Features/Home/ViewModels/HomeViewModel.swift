import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var products: [ProductModel] = []
    @Published var isLoading = false
    @Published var selectedCountry = "US"
    @Published var selectedCategory: Category?
    @Published var searchText = ""
    
    private let supabase = AppSupabaseClient.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // Load initial data
        loadProducts()
    }
    
    func loadProducts() {
        isLoading = true
        
        // Simulate network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            // Mock Data
            var newProducts = [
                ProductModel.mock(),
                ProductModel(
                    id: UUID(),
                    title: "Nintendo Switch OLED - White Joy-Con",
                    description: "7-inch OLED screen - Enjoy vivid colors and crisp contrast with a screen that makes colors pop",
                    imageUrl: "switch_oled",
                    currentPrice: 299.00,
                    originalPrice: 349.99,
                    targetResellPrice: 400.00,
                    countryCode: "US",
                    category: Category.all[2], // Toys/Gaming
                    postedAt: Date().addingTimeInterval(-3600),
                    source: "Walmart",
                    profitPercentage: 33,
                    isSaved: false
                ),
                ProductModel(
                    id: UUID(),
                    title: "Dyson Airwrap Multi-Styler Complete Long",
                    description: "Coanda airflow technology, standard styling attachments.",
                    imageUrl: "dyson_airwrap",
                    currentPrice: 400.00,
                    originalPrice: 599.99,
                    targetResellPrice: 550.00,
                    countryCode: "US",
                    category: Category.all[1], // Home
                    postedAt: Date().addingTimeInterval(-7200),
                    source: "BestBuy",
                    profitPercentage: 37,
                    isSaved: true
                )
            ]
            
            // Filter logic (Local for now)
            if let category = self?.selectedCategory {
                newProducts = newProducts.filter { $0.category.id == category.id }
            }
            
            self?.products = newProducts
            self?.isLoading = false
        }
    }
    
    func refresh() {
        loadProducts()
    }
    
    func toggleSave(_ product: ProductModel) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            products[index] = ProductModel(
                id: product.id,
                title: product.title,
                description: product.description,
                imageUrl: product.imageUrl,
                currentPrice: product.currentPrice,
                originalPrice: product.originalPrice,
                targetResellPrice: product.targetResellPrice,
                countryCode: product.countryCode,
                category: product.category,
                postedAt: product.postedAt,
                source: product.source,
                profitPercentage: product.profitPercentage,
                isSaved: !product.isSaved
            )
        }
    }
}
