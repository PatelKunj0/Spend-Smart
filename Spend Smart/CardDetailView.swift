import SwiftUI

// View that displays detailed information for a specific card
struct CardDetailView: View {
    let card: Card  // The card object passed to this view
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                
                // Card header with a rounded rectangle displaying the card's name
                RoundedRectangle(cornerRadius: 16)
                    .fill(card.color.opacity(0.85))
                    .frame(height: 120)
                    .overlay(
                        Text(card.name)
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                    )
                    .padding(.horizontal)  // Add horizontal padding
                
                // Rotating offers section with conditional views for rewards
                VStack(alignment: .leading, spacing: 24) {
                    
                    Text("Rotating Offers")
                        .font(.title2)
                        .bold()
                        .padding(.horizontal)
                    
                    // Display rotating rewards if available
                    if !card.rotatingRewards.isEmpty {
                        DiscoverRotatingRewardsView(rewards: card.rotatingRewards)
                    }
                    
                    // Display merchant-specific rewards if available
                    if !card.merchantRewards.isEmpty {
                        MerchantRotatingRewardsView(rewards: card.merchantRewards)
                    }
                }
                
                // Navigation link to view permanent rewards
                NavigationLink {
                    PermanentRewardsView(
                        rewards: card.permanentRewards,
                        cardName: card.name
                    )
                } label: {
                    // Permanent Rewards button
                    Text("Permanent Rewards")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)  // Button background color
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)  // Add horizontal padding
                
            }
            .navigationTitle(card.name)  // Set navigation title to card's name
            .navigationBarTitleDisplayMode(.inline)  // Display title inline
        }
    }
}

#Preview {
    // Preview the CardDetailView with an example card
    CardDetailView(card: Card(name: "Example Card", issuer: "Issuer", color: .blue))
}
