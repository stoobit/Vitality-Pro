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
        .onAppear {
            requestNotifications()
            setNotifications()
        }
    }

    func requestNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]
        ) { _, _ in
            setNotifications()
        }
    }

    func setNotifications() {
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.subtitle = "Don't forget to eat enough vitamins."
        content.sound = UNNotificationSound.default

        var date = DateComponents()
        date.hour = 17
        date.minute = 15

        let id = "dailynotification"

        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }
}
