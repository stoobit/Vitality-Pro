import SwiftUI

@main
struct VitalityPro: App {
    @State var healthViewModel = HealthKitViewModel()

    var body: some Scene {
        WindowGroup {
            VStack {
                if healthViewModel.isAuthorized {
                    ContentView()
                } else {
                    UnavailableView()
                }
            }
            .environment(healthViewModel)
        }
    }
}
