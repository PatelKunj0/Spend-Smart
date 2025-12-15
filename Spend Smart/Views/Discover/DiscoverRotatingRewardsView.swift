import SwiftUI

struct DiscoverRotatingRewardsView: View {
    let rewards: [RotatingReward]

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(rewards) { reward in
                VStack(alignment: .leading, spacing: 6) {

                    Text(reward.dateRange)
                        .font(.headline)
                        .bold()
                    
                    Text(reward.title)
                        .font(.subheadline)
                        .foregroundColor(.primary)

                    Text("\(reward.cashbackPercent)% cash back")
                        .font(.subheadline)
                        .foregroundColor(.primary)

                    statusLabel(for: reward.status)
                }
                .padding()
                .frame(maxWidth: .infinity, minHeight: 150, alignment: .topLeading)
                .background(Color(.systemGray6))
                .cornerRadius(14)
            }
        }
    }

    @ViewBuilder
    private func statusLabel(for status: RewardStatus) -> some View {
        switch status {
        case .active:
            Text("Active")
                .font(.subheadline)
                .foregroundColor(.green)

        case .announced:
            Text("Active soon")
                .font(.subheadline)
                .foregroundColor(.blue)

        case .comingSoon:
            Text("Coming soon")
                .font(.subheadline)
                .foregroundColor(.orange)
        }
    }
}
