import SwiftUI

struct PermanentRewardsView: View {
    let rewards: [PermanentReward]
    let cardName: String
    
    var body: some View {
        List {
            Section("Permanent Rewards") {
                ForEach(rewards) { reward in
                    HStack {
                        Text(reward.category)
                            .font(.body)

                        Spacer()

                        Text("\(reward.percent)%")
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                    .padding(.vertical, 8)
                }
            }
        }
        .navigationTitle("\(cardName) Rewards")
        .navigationBarTitleDisplayMode(.inline)
    }
}
