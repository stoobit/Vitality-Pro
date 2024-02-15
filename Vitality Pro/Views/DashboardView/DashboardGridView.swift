import SwiftUI

struct DashboardGridView: View {
    let columns = [GridItem(.adaptive(minimum: 350))]
    var days: [String: Day]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(vitamins) { vitamin in
                    DashboardCardView(vitamin: vitamin, days: days)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
        }
    }
}
