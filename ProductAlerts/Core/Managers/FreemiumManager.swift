import Foundation

class FreemiumManager: ObservableObject {
    static let shared = FreemiumManager()
    
    // Constants
    private let maxFreeAlerts = 4
    private let userDefaults = UserDefaults.standard
    private let viewCountKeyPrefix = "view_count_"
    
    @Published var alertsRemaining: Int = 4
    
    init() {
        refreshRemainingCount()
    }
    
    // MARK: - Public API
    
    func canViewAlert(isPremium: Bool) -> Bool {
        if isPremium { return true }
        
        // Check if limit reached
        let count = getCurrentCount()
        return count < maxFreeAlerts
    }
    
    func trackAlertView(isPremium: Bool) {
        guard !isPremium else { return }
        
        let count = getCurrentCount()
        if count < maxFreeAlerts {
            let newCount = count + 1
            userDefaults.set(newCount, forKey: currentDayKey)
            refreshRemainingCount()
        }
    }
    
    // MARK: - Private Helpers
    
    private var currentDayKey: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return viewCountKeyPrefix + formatter.string(from: Date())
    }
    
    private func getCurrentCount() -> Int {
        // Reset check is implicit by using the date in the key.
        // If the key (date) changes, the count starts at 0 for the new key.
        return userDefaults.integer(forKey: currentDayKey)
    }
    
    private func refreshRemainingCount() {
        let count = getCurrentCount()
        alertsRemaining = max(0, maxFreeAlerts - count)
    }
}
