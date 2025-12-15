import SwiftUI

// Rotating rewards with time-sensitive offers
struct RotatingReward: Identifiable, Hashable {
    let id = UUID()  // Unique identifier
    let dateRange: String  // Validity period
    let title: String  // Reward title
    let cashbackPercent: Int  // Cashback percentage
    let status: RewardStatus  // Reward status (active, announced, comingSoon)
}

// Reward status options
enum RewardStatus: String, Hashable {
    case active, announced, comingSoon
}

// Credit card with various types of rewards
struct Card: Identifiable, Hashable {
    let id = UUID()  // Unique identifier
    let name: String  // Card name
    let issuer: String  // Card issuer
    let color: Color  // Card color
    var rotatingRewards: [RotatingReward] = []  // Rotating rewards
    var merchantRewards: [MerchantReward] = []  // Merchant-specific rewards
    var permanentRewards: [PermanentReward] = []  // Permanent rewards
}

// Merchant-specific rewards with cashback offers
struct MerchantReward: Identifiable, Hashable {
    let id = UUID()  // Unique identifier
    let merchantName: String  // Merchant name
    let cashbackText: String  // Cashback description
    let imageName: String?  // Optional image name for the merchant logo
}

// Permanent rewards with fixed cashback percentages
struct PermanentReward: Identifiable, Hashable {
    let id = UUID()  // Unique identifier
    let category: String  // Reward category (e.g., "Dining")
    let percent: Int  // Cashback percentage
}
