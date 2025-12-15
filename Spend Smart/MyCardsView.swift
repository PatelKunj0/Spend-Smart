import SwiftUI

struct MyCardsView: View {
    @ObservedObject var store: CardStore
    @Binding var path: [Route]
    
    var selectedCards: [Card] {
        store.allCards.filter { store.selectedCardIDs.contains($0.id) }
    }
    
    var body: some View {
        List {
            Section("Your Cards") {
                ForEach(selectedCards) { card in
                    NavigationLink(value: Route.cardDetail(card)) {
                        HStack(spacing: 16) {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(card.color.opacity(0.85))
                                .frame(width: 60, height: 40)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Text(card.name)
                                        .font(.headline)
                                    
                                    // Best “everywhere else” card
                                    if store.bestGeneralCardID() == card.id {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                    }
                                }
                                
                                Text(card.issuer)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .navigationTitle("My Cards")
    }
}

#Preview {
    NavigationStack {
        MyCardsView(store: CardStore(), path: .constant([]))
    }
}
