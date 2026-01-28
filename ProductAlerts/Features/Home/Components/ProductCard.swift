import SwiftUI

struct ProductCard: View {
    let product: ProductModel
    let onSave: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Image Section
            ZStack(alignment: .topTrailing) {
                // Placeholder Image
                Rectangle()
                    .fill(Theme.warmGray.opacity(0.3))
                    .aspectRatio(16/9, contentMode: .fit)
                    .overlay(
                        Image(systemName: "photo")
                            .foregroundColor(Theme.textPrimary.opacity(0.2))
                    )
                    .cornerRadius(Spacing.CornerRadius.medium, corners: [.topLeft, .topRight])
                
                // Bookmark Button
                Button(action: onSave) {
                    Image(systemName: product.isSaved ? "heart.fill" : "heart")
                        .foregroundColor(product.isSaved ? Theme.mutedRed : Theme.textPrimary)
                        .padding(8)
                        .background(.thinMaterial)
                        .clipShape(Circle())
                }
                .padding(8)
            }
            
            VStack(alignment: .leading, spacing: 12) {
                // Title
                Text(product.title)
                    .customFont(AppFont.subheadline())
                    .lineLimit(2)
                    .foregroundColor(Theme.textPrimary)
                    .frame(height: 40, alignment: .topLeading)
                
                // Price & Profit Section
                VStack(alignment: .leading, spacing: 8) {
                    HStack(alignment: .firstTextBaseline) {
                        Text("$\(String(format: "%.2f", product.currentPrice))")
                            .customFont(AppFont.headline())
                            .foregroundColor(Theme.accent)
                        
                        Text("$\(String(format: "%.2f", product.targetResellPrice))")
                            .strikethrough()
                            .customFont(AppFont.caption())
                            .foregroundColor(Theme.textPrimary.opacity(0.5))
                            
                        Spacer()
                        
                        // Profit Badge
                        Text("+\(product.profitPercentage)%")
                            .customFont(AppFont.caption())
                            .fontWeight(.bold)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(
                                LinearGradient(colors: [Theme.profitHighlight, Theme.success.opacity(0.3)], startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(Spacing.CornerRadius.small)
                    }
                    
                    // Visual Profit Bar
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Theme.warmGray)
                                .frame(height: 4)
                            
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Theme.success)
                                .frame(width: geo.size.width * (CGFloat(product.profitPercentage) / 100.0), height: 4)
                        }
                    }
                    .frame(height: 4)
                    
                    HStack {
                        Label {
                            Text(product.source)
                        } icon: {
                            Image(systemName: "cart")
                        }
                        .font(AppFont.caption())
                        .foregroundColor(Theme.textPrimary.opacity(0.6))
                        
                        Spacer()
                        
                        Text(timeAgo(date: product.postedAt))
                            .font(AppFont.caption())
                            .foregroundColor(Theme.textPrimary.opacity(0.6))
                    }
                }
            }
            .padding(12)
        }
        .background(Color.white)
        .cornerRadius(Spacing.CornerRadius.medium)
        .shadow(color: Spacing.Shadow.soft, radius: 8, x: 0, y: 4)
    }
    
    // Helper helper for corners
    func timeAgo(date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}

// Rounded Corner Extension
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
