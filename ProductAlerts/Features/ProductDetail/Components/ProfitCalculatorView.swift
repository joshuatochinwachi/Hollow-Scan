import SwiftUI

struct ProfitCalculatorView: View {
    let originalBuy: Double
    let originalSell: Double
    
    @State private var buyPrice: String
    @State private var sellPrice: String
    @State private var fees: String = "15.0"
    
    init(buy: Double, sell: Double) {
        self.originalBuy = buy
        self.originalSell = sell
        _buyPrice = State(initialValue: String(format: "%.2f", buy))
        _sellPrice = State(initialValue: String(format: "%.2f", sell))
    }
    
    var profit: Double {
        let buy = Double(buyPrice) ?? 0
        let sell = Double(sellPrice) ?? 0
        let fee = Double(fees) ?? 0
        return sell - buy - fee
    }
    
    var roi: Double {
        let buy = Double(buyPrice) ?? 0
        guard buy > 0 else { return 0 }
        return (profit / buy) * 100
    }
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("💰 Profit Breakdown")
                    .customFont(AppFont.headline())
                Spacer()
                Button(action: {
                    // Reset to defaults
                    buyPrice = String(format: "%.2f", originalBuy)
                    sellPrice = String(format: "%.2f", originalSell)
                }) {
                    Image(systemName: "arrow.counterclockwise")
                        .foregroundColor(Theme.textPrimary.opacity(0.5))
                }
            }
            
            Divider()
            
            // Inputs
            HStack(spacing: 20) {
                CalculatorInput(title: "Buy Price", value: $buyPrice)
                CalculatorInput(title: "Sell Price", value: $sellPrice)
                CalculatorInput(title: "Est. Fees", value: $fees)
            }
            
            Divider()
            
            // Results
            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Text("Net Profit")
                        .customFont(AppFont.caption())
                        .foregroundColor(Theme.textPrimary.opacity(0.6))
                    Text("$\(String(format: "%.2f", profit))")
                        .customFont(AppFont.title2())
                        .foregroundColor(profit > 0 ? Theme.success : Theme.error)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("ROI")
                        .customFont(AppFont.caption())
                        .foregroundColor(Theme.textPrimary.opacity(0.6))
                    Text("\(String(format: "%.0f", roi))%")
                        .customFont(AppFont.title2())
                        .foregroundColor(roi > 20 ? Theme.success : Theme.textPrimary)
                }
            }
        }
        .padding()
        .background(
            LinearGradient(colors: [Color.white, Theme.background], startPoint: .top, endPoint: .bottom)
        )
        .cornerRadius(Spacing.CornerRadius.medium)
        .shadow(color: Spacing.Shadow.soft, radius: 4)
    }
}

struct CalculatorInput: View {
    let title: String
    @Binding var value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .customFont(AppFont.caption())
                .foregroundColor(Theme.textPrimary.opacity(0.6))
            
            TextField("", text: $value)
                .keyboardType(.decimalPad)
                .font(AppFont.callout())
                .padding(8)
                .background(Color.white)
                .cornerRadius(Spacing.CornerRadius.small)
                .overlay(
                    RoundedRectangle(cornerRadius: Spacing.CornerRadius.small)
                        .stroke(Theme.warmGray, lineWidth: 1)
                )
        }
    }
}
