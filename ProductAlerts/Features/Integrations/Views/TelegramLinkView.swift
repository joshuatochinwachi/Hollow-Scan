import SwiftUI

struct TelegramLinkView: View {
    @State private var linkCode: String = ""
    @State private var timeRemaining = 300 // 5 minutes
    @State private var isLinked = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Theme.background.edgesIgnoringSafeArea(.all)
            
            if isLinked {
                SuccessStateView()
            } else {
                ScrollView {
                    VStack(spacing: 24) {
                        // Hero
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 60))
                            .foregroundColor(Theme.mutedTeal) // Telegram color-ish
                            .padding(.top, 40)
                        
                        Text("Sync Your Subscription")
                            .customFont(AppFont.title1())
                        
                        Text("Link your Telegram account to\nsync subscription status")
                            .customFont(AppFont.body())
                            .multilineTextAlignment(.center)
                            .foregroundColor(Theme.textPrimary.opacity(0.7))
                        
                        // Code Card
                        VStack(spacing: 20) {
                            Text("Your Link Code:")
                                .customFont(AppFont.headline())
                                .foregroundColor(Theme.textPrimary.opacity(0.6))
                            
                            HStack(spacing: 12) {
                                ForEach(Array(linkCode), id: \.self) { char in
                                    Text(String(char))
                                        .font(.system(size: 32, weight: .bold, design: .monospaced))
                                        .frame(width: 40, height: 50)
                                        .background(Theme.warmGray.opacity(0.3))
                                        .cornerRadius(8)
                                }
                            }
                            
                            HStack(spacing: 20) {
                                Button("Copy Code") {
                                    UIPasteboard.general.string = linkCode
                                }
                                .font(AppFont.callout())
                                
                                Button("Generate New") {
                                    generateCode()
                                }
                                .font(AppFont.callout())
                            }
                            .foregroundColor(Theme.primaryAction)
                            
                            Text("Expires in: \(timeString(time: timeRemaining))")
                                .font(AppFont.caption())
                                .foregroundColor(Theme.mutedRed)
                                .onReceive(timer) { _ in
                                    if timeRemaining > 0 {
                                        timeRemaining -= 1
                                    } else {
                                        generateCode()
                                    }
                                }
                        }
                        .padding(30)
                        .background(Color.white)
                        .cornerRadius(Spacing.CornerRadius.large)
                        .shadow(color: Spacing.Shadow.soft, radius: 10)
                        
                        // Instructions
                        VStack(alignment: .leading, spacing: 16) {
                            InstructionRow(step: "1", text: "Open Telegram")
                            InstructionRow(step: "2", text: "Find @ProductAlertsBot")
                            InstructionRow(step: "3", text: "Send: /link \(linkCode)")
                        }
                        .padding()
                        
                        // Action
                        Button(action: {
                            // Open Telegram Data Link
                             isLinked = true // Simulate user linking
                        }) {
                            Text("Open Telegram Bot")
                                .customFont(AppFont.headline())
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Theme.mutedTeal)
                                .cornerRadius(Spacing.CornerRadius.large)
                        }
                        .padding(.horizontal)
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            generateCode()
        }
    }
    
    func generateCode() {
        // Generate random 6 digit code
        linkCode = String((0..<6).map { _ in "0123456789".randomElement()! })
        timeRemaining = 300
    }
    
    func timeString(time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct InstructionRow: View {
    let step: String
    let text: String
    
    var body: some View {
        HStack(spacing: 16) {
            Text(step)
                .font(AppFont.headline())
                .frame(width: 30, height: 30)
                .background(Theme.warmGray)
                .clipShape(Circle())
            
            Text(text)
                .customFont(AppFont.body())
            
            Spacer()
        }
    }
}

struct SuccessStateView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(Theme.success)
            
            Text("Successfully Linked!")
                .customFont(AppFont.title1())
            
            Text("Your Telegram account is now connected")
                .customFont(AppFont.body())
                .foregroundColor(Theme.textPrimary.opacity(0.6))
        }
    }
}
