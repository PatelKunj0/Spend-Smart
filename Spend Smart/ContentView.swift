import SwiftUI

enum Route: Hashable {
    case myCards
    case cardDetail(Card)
}

struct ContentView: View {
    @StateObject private var store = CardStore()
    @State private var path: [Route] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                // CARD SELECTION LIST
                List {
                    Section("Choose the cards you own") {
                        ForEach(store.allCards) { card in
                            Button {
                                store.toggleSelection(for: card)
                            } label: {
                                HStack(spacing: 16) {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(card.color.opacity(0.85))
                                        .frame(width: 60, height: 40)
                                        .overlay(
                                            Text(String(card.issuer.prefix(1)))
                                                .font(.headline)
                                                .foregroundColor(.white)
                                        )
                                    
                                    VStack(alignment: .leading) {
                                        Text(card.name)
                                            .font(.headline)
                                        Text(card.issuer)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Spacer()
                                    
                                    Image(systemName: store.isSelected(card) ? "checkmark.circle.fill" : "circle")
                                        .imageScale(.large)
                                        .foregroundColor(store.isSelected(card) ? .green : .secondary)
                                }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                
                // CONTINUE BUTTON
                Button {
                    path.append(.myCards) 
                } label: {
                    Text("Continue")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(store.selectedCardIDs.isEmpty ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding()
                }
                .disabled(store.selectedCardIDs.isEmpty)
            }
            .navigationTitle("Spend Smart")
            
            // NAVIGATION DESTINATIONS
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .myCards:
                    MyCardsView(store: store, path: $path)
                case .cardDetail(let card):
                    CardDetailView(card: card)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
