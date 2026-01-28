import SwiftUI

struct EmailVerificationView: View {
    @State private var code: [String] = Array(repeating: "", count: 6)
    @FocusState private var focusedField: Int?
    @State private var timeRemaining = 45
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Theme.background.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 32) {
                // Header
                VStack(spacing: 16) {
                    Image(systemName: "envelope.open.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 80)
                        .foregroundColor(Theme.primaryAction)
                        .padding(.top, 40)
                    
                    Text("Verify Your Email")
                        .customFont(AppFont.title1())
                    
                    Text("We sent a 6-digit code to:\nuser@example.com")
                        .customFont(AppFont.body())
                        .multilineTextAlignment(.center)
                        .foregroundColor(Theme.textPrimary.opacity(0.7))
                }
                
                // OTP Input
                HStack(spacing: 8) {
                    ForEach(0..<6, id: \.self) { index in
                        TextField("", text: $code[index])
                            .keyboardType(.numberPad)
                            .frame(width: 45, height: 55)
                            .background(Color.white)
                            .cornerRadius(Spacing.CornerRadius.small)
                            .multilineTextAlignment(.center)
                            .overlay(
                                RoundedRectangle(cornerRadius: Spacing.CornerRadius.small)
                                    .stroke(focusedField == index ? Theme.primaryAction : Theme.warmGray, lineWidth: 2)
                            )
                            .focused($focusedField, equals: index)
                            .tag(index)
                            .onChange(of: code[index]) { newValue in
                                if newValue.count > 1 {
                                    code[index] = String(newValue.last!)
                                }
                                if !newValue.isEmpty {
                                    if index < 5 {
                                        focusedField = index + 1
                                    } else {
                                        focusedField = nil // Hide keyboard
                                        verifyCode()
                                    }
                                }
                            }
                    }
                }
                
                // Timer & Resend
                VStack(spacing: 16) {
                    if timeRemaining > 0 {
                        Text("Resend code (\(timeRemaining)s)")
                            .customFont(AppFont.callout())
                            .foregroundColor(Theme.textPrimary.opacity(0.5))
                            .onReceive(timer) { _ in
                                if timeRemaining > 0 { timeRemaining -= 1 }
                            }
                    } else {
                        Button("Resend Code") {
                            timeRemaining = 45
                            // Trigger resend logic
                        }
                        .customFont(AppFont.headline())
                        .foregroundColor(Theme.primaryAction)
                    }
                    
                    Button("Wrong email? Edit") { }
                        .customFont(AppFont.subheadline())
                        .foregroundColor(Theme.textPrimary)
                }
                
                Spacer()
                
                Button(action: verifyCode) {
                    Text("Verify")
                        .customFont(AppFont.headline())
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Theme.primaryAction)
                        .cornerRadius(Spacing.CornerRadius.large)
                }
                .padding(.horizontal, Spacing.large)
                .padding(.bottom, Spacing.extraLarge)
            }
        }
        .onAppear {
            focusedField = 0
        }
    }
    
    func verifyCode() {
        // Implement verification logic
        let fullCode = code.joined()
        print("Verifying code: \(fullCode)")
    }
}
