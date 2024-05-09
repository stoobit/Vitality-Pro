import Mixpanel
import SwiftUI

@main
struct VitalityPro: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) var scenePhase

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
                healthViewModel.healthRequest()
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

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        Mixpanel.initialize(
            token: "a7ee64aa1d66781642086b8d724cfd0b",
            trackAutomaticEvents: false
        )

        Mixpanel.mainInstance()
            .track(event: "Signed Up", properties: [:])

        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = .systemOrange

        return true
    }
}
