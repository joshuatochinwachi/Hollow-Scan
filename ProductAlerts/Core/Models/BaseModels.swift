import Foundation

struct User: Codable, Identifiable {
    let id: UUID
    let email: String
    let fullName: String?
    let subscriptionStatus: SubscriptionStatus
    let freeAlertsRemaining: Int
    let preferredCountry: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case fullName = "full_name"
        case subscriptionStatus = "subscription_status"
        case freeAlertsRemaining = "free_alerts_remaining"
        case preferredCountry = "preferred_country"
    }
}

enum SubscriptionStatus: String, Codable {
    case free
    case active
    case pastDue = "past_due"
    case cancelled
}

struct Category: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let icon: String // SF Symbol name
    
    static let all = [
        Category(id: "tech", name: "Electronics", icon: "desktopcomputer"),
        Category(id: "home", name: "Home", icon: "house"),
        Category(id: "toys", name: "Toys", icon: "gamecontroller"),
        Category(id: "fashion", name: "Fashion", icon: "tshirt")
    ]
}

struct ProductModel: Codable, Identifiable {
    let id: UUID
    let title: String
    let description: String
    let imageUrl: String
    let currentPrice: Double
    let originalPrice: Double
    let targetResellPrice: Double
    let countryCode: String
    let category: Category
    let postedAt: Date
    let source: String // e.g., "Amazon", "eBay"
    let profitPercentage: Int
    let isSaved: Bool
    
    var profitAmount: Double {
        return targetResellPrice - currentPrice
    }
    
    // Mock Data Generator
    static func mock() -> ProductModel {
        return ProductModel(
            id: UUID(),
            title: "Sony WH-1000XM5 Wireless Noise Cancelling Headphones",
            description: "Industry leading noise cancellation-two processors control 8 microphones for unprecedented noise cancellation.",
            imageUrl: "https://example.com/headphones.jpg",
            currentPrice: 248.00,
            originalPrice: 349.99,
            targetResellPrice: 320.00,
            countryCode: "US",
            category: Category.all[0],
            postedAt: Date(),
            source: "Amazon FBA",
            profitPercentage: 29,
            isSaved: false
        )
    }
}
