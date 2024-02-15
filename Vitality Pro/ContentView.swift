import SwiftUI

struct ContentView: View {
    let userdefaultskey: String = "$daydata"
    @State var days: [String: Day] = [:]
    @AppStorage("last opened") var date: Data = .init()
    @State var properties: PropertyModel = .init()
    
    var body: some View {
        @Bindable var properties = properties
        
        NavigationStack {
            DashboardView(days: days)
                .navigationTitle("Vitality Pro")
                .toolbar { ToolbarView() }
                .toolbarRole(.editor)
                .fullScreenCover(isPresented: $properties.showCamera, content: {
                    CameraView { food in
                        if let food = food {
                            add(food: food)
                        }
                    }
                })
                .sheet(isPresented: $properties.showInfo, content: {
                    InfoView()
                        .scrollIndicators(.never)
                })
                .sheet(isPresented: $properties.showSettings, content: {
                    SettingsView()
                        .scrollIndicators(.never)
                })
                .onAppear {
                    setDays()
                    accessHealthData()
                }
                .onChange(of: days) {
                    saveDays()
                }
                .environment(properties)
        }
    }
    
    func add(food: Food) {
        let day = Date().getWeekday()
        
        for vitamin in food.vitamins {
            let amount = Amount(vitamin: vitamin.key, value: vitamin.value)
            days[day]?.amounts.append(amount)
        }
    }
    
    func accessHealthData() {}
}
