import SwiftUI

@main
struct VitalityPro: App {
    @AppStorage("biologicalsex") var biologicalFemale: Bool = true
    @AppStorage("firstopen") var firstOpen: Bool = true

    @State var healthViewModel = HealthKitViewModel()

    var body: some Scene {
        WindowGroup {
            VStack {
                if healthViewModel.isAuthorized {
                    ContentView()
                        .onAppear {
                            sex()
                        }

                } else {
                    UnavailableView()
                }
            }
            .animation(.bouncy, value: healthViewModel.isAuthorized)
            .environment(healthViewModel)
            .fullScreenCover(isPresented: $firstOpen, onDismiss: {
                healthViewModel.healthRequest()
            }) {
                OnboardingView()
                    .environment(healthViewModel)
            }
            .onAppear {
                authorization()
            }
        }
    }

    func authorization() {
        if firstOpen == false {
            healthViewModel.changeAuthorizationStatus()
        }
    }

    func sex() {
        healthViewModel.loadBiologicalSex()
        if healthViewModel.biologicalSex == .male {
            biologicalFemale = false
        }
    }
}
