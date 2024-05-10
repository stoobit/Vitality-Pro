import StoreKit
import SwiftUI

struct SettingsView: View {
    @StateObject private var store = TipsStore()
    @Environment(\.dismiss) var dismiss
    
    @AppStorage("biologicalsex") var biologicalFemale: Bool = true
    @AppStorage("percentagegoal") var percentage: Double = 0.5
    @AppStorage("notifications") var notifications: Bool = false
    
    @State var alert: Bool = false
    
    let sexlabel = "The recommended vitamin amount differs for biological males and females."
    
    let percentagelabel = "Set a proportion of the minimum recommended daily amount as your daily goal."
    
    let notificationsLabel = "Receive a notification every day at 5:15 p.m. reminding you to eat enough fruits/vegetables."
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Biological Sex", selection: $biologicalFemale) {
                        Text("Female")
                            .tag(true)
                        
                        Text("Male")
                            .tag(false)
                    }
                } footer: {
                    Label(sexlabel, systemImage: "person.fill")
                }
                
                Section {
                    Stepper(value: $percentage, in: 0.25 ... 2, step: Double(0.05)) {
                        Text("\(String((percentage * 100).rounded(toPlaces: 2)))%")
                    }
                } footer: {
                    Label(percentagelabel, systemImage: "flag.fill")
                }
                
                Section {
                    Toggle("Notifications", isOn: $notifications)
                        .tint(Color.orange)
                        .onChange(of: notifications) {
                            if notifications {
                                requestNotifications()
                                setNotifications()
                            } else {
                                UNUserNotificationCenter.current()
                                    .removeAllPendingNotificationRequests()
                            }
                        }
                    
                } footer: {
                    Label(notificationsLabel, systemImage: "bell.fill")
                }
                
                Section("Support Me") {
                    ProductView(id: "com.stoobit.vitalitiypro.purchase.medium", icon: {
                        Image(systemName: "cup.and.saucer.fill")
                            .padding(.trailing, 2)
                    })
                    .productViewStyle(.compact)
                }
                .onInAppPurchaseStart(perform: { _ in })
                .onInAppPurchaseCompletion { _, result in
                    if case .success(.success(_)) = result {
                        alert.toggle()
                    }
                }
            }
            .environment(\.defaultMinListRowHeight, 55)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done", action: { dismiss() })
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Text("Settings")
                        .foregroundStyle(Color.primary)
                        .font(.headline.bold())
                }
            }
            .alert("Thank You!", isPresented: $alert) {
                Button("Close", role: .cancel) { alert = false }
            }
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

#Preview {
    SettingsView()
}
