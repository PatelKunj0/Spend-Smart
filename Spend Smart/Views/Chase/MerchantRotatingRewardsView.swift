import SwiftUI

struct MerchantRotatingRewardsView: View {
    let rewards: [MerchantReward]
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(rewards) { reward in
                VStack(alignment: .leading, spacing: 8) {
                    
                    // Image placeholder (wll be replaced later)
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray4))
                        .frame(height: 80)
                        .overlay(
                            Text(reward.merchantName.prefix(1))
                                .font(.title)
                                .foregroundColor(.white)
                        )
                    
                    Text(reward.merchantName)
                        .font(.headline)
                    
                    Text(reward.cashbackText)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity, minHeight: 170)
                .background(Color(.systemGray6))
                .cornerRadius(16)
            }
        }
        .padding(.horizontal)
    }
}
