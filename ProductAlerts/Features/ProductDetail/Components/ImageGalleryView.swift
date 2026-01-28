import SwiftUI

struct ImageGalleryView: View {
    let images: [String] // URL strings
    @State private var currentPage = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $currentPage) {
                // Placeholder - looping same image if array empty or single
                if images.isEmpty {
                    ImagePlaceholder()
                } else {
                    ForEach(0..<images.count, id: \.self) { index in
                        // AsyncImage in real app
                        ImagePlaceholder(url: images[index])
                            .tag(index)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 300)
            
            // Page Indicators
            if images.count > 1 {
                HStack(spacing: 8) {
                    ForEach(0..<images.count, id: \.self) { index in
                        Circle()
                            .fill(currentPage == index ? Theme.primaryAction : Theme.warmGray)
                            .frame(width: 8, height: 8)
                            .scaleEffect(currentPage == index ? 1.2 : 1.0)
                            .animation(.spring(), value: currentPage)
                    }
                }
                .padding(.bottom, 16)
            }
        }
    }
}

struct ImagePlaceholder: View {
    var url: String?
    
    var body: some View {
        Rectangle()
            .fill(Theme.warmGray.opacity(0.3))
            .overlay(
                Image(systemName: "photo")
                    .font(.system(size: 40))
                    .foregroundColor(Theme.textPrimary.opacity(0.2))
            )
    }
}
