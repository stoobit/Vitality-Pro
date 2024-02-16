import SwiftUI

struct DashboardView: View {
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea(.all)

            DashboardGridView()
                .scrollIndicators(.hidden)
        }
    }
}
