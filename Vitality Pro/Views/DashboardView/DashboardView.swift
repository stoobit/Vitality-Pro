import SwiftUI

struct DashboardView: View {
    var days: [String: Day]

    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea(.all)

            DashboardGridView(days: days)
                .scrollIndicators(.hidden)
        }
    }
}
