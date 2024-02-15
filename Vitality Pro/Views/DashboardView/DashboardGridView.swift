import SwiftUI

struct DashboardGridView: View {
    let columns = [GridItem(.adaptive(minimum: 350))]
    var days: [String: Day]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 5) {
                ForEach(vitamins) { vitamin in
                    DashboardCardView(vitamin: vitamin, days: days)
                        .padding()
                }
            }
            .padding()
        }
    }
}
