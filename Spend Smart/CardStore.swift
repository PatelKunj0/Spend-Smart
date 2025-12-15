import SwiftUI
internal import Combine

// CardStore is an ObservableObject that manages a list of cards and selected card IDs
final class CardStore: ObservableObject {
    
    // Published property to hold all available cards
    @Published var allCards: [Card] = [
        // Discover it card with rotating and permanent rewards
        Card(
            name: "Discover it®",
            issuer: "Discover",
            color: .orange,
            rotatingRewards: [
                RotatingReward(
                    dateRange: "Oct–Dec 2025",
                    title: "Amazon.com and Drug Stores",
                    cashbackPercent: 5,
                    status: .active
                ),
                // Additional rotating rewards...
            ],
            permanentRewards: [
                PermanentReward(category: "Everything else", percent: 1)  // Permanent reward for "Everything else" category
            ],
        ),
        
        // Chase Freedom Flex card with merchant and permanent rewards
        Card(
            name: "Chase Freedom Flex℠",
            issuer: "Chase",
            color: .blue,
            merchantRewards: [
                // Merchant rewards with cashback offers
                MerchantReward(merchantName: "Funko", cashbackText: "10% cash back", imageName: nil),
                // Additional merchant rewards...
            ],
            permanentRewards: [
                // Permanent rewards with categories like Travel and Dining
                PermanentReward(category: "Travel (Chase Ultimate Rewards)", percent: 5),
                PermanentReward(category: "Dining", percent: 3)
            ]
        ),
        
        // A card without rotating or merchant rewards, but with permanent rewards
        Card(
            name: "Robinhood Gold Card",
            issuer: "Robinhood",
            color: Color(red: 0.85, green: 0.65, blue: 0.13),
            rotatingRewards: [],  // No rotating rewards for this card
            merchantRewards: [],
            permanentRewards: [
                PermanentReward(category: "Everything else", percent: 3),
                PermanentReward(category: "Travel (Robinhood Travel)", percent: 5),
            ]
        ),
    ]
    
    // Published property to track the selected cards by their UUIDs
    @Published var selectedCardIDs: Set<UUID> = []
    
    // Method to toggle the selection of a card
    func toggleSelection(for card: Card) {
        if selectedCardIDs.contains(card.id) {
            selectedCardIDs.remove(card.id)
        } else {
            selectedCardIDs.insert(card.id)
        }
    }
    
    // Method to check if a card is selected
    func isSelected(_ card: Card) -> Bool {
        selectedCardIDs.contains(card.id)
    }
    
    // Method to find the card with the best "Everything else" reward percentage
    func bestGeneralCardID() -> UUID? {
        var bestCard: Card?
        var highestPercent = 0

        for card in allCards {
            if selectedCardIDs.contains(card.id) {
                // Find the "Everything else" reward in the card's permanent rewards
                if let reward = card.permanentRewards.first(where: {
                    $0.category.lowercased().contains("everything else")
                }) {
                    // Track the card with the highest "Everything else" reward percentage
                    if reward.percent > highestPercent {
                        highestPercent = reward.percent
                        bestCard = card
                    }
                }
            }
        }

        return bestCard?.id  // Return the best card's ID
    }
}
