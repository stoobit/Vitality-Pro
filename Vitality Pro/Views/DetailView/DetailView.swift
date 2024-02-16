import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    
    var vitamin: Vitamin
    var emojis: [Emoji]
    var days: [String: Day]
    
    var body: some View {
        NavigationStack {
            Form {
                DetailInfoView(vitamin: vitamin, emojis: emojis, days: days)
                DetailStatisticsView(vitamin: vitamin, days: days)
            }
            .environment(\.defaultMinListRowHeight, 55)
            .scrollIndicators(.never)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done", action: { dismiss() })
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Text(vitamin.title)
                        .foregroundStyle(Color.primary)
                        .font(.headline.bold())
                }
            }
        }
    }
}
