import SwiftUI

struct ContentView: View {
    let userdefaultskey: String = "$daydata"
    
    @State var properties: PropertyModel = .init()
    @State var days: [String: Day] = [:]
    
    @AppStorage("last opened") var date: Data = Data()
    
    var body: some View {
        @Bindable var properties = properties
        
        NavigationStack {
            DashboardView(days: days)
                .navigationTitle("Vitatrack")
                .toolbarRole(.editor)
                .toolbar(content: {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Camera", systemImage: "camera.fill", action: {
                            self.properties.showCamera.toggle()
                        })
                    }
                    
                    ToolbarItemGroup(placement: .topBarLeading) {
                        Button("Settings", systemImage: "gearshape.fill", action: {
                            self.properties.showSettings.toggle()
                        })
                        
                        Button("Information", systemImage: "carrot.fill", action: {
                            self.properties.showInfo.toggle()
                        })
                    }
                })
                .fullScreenCover(isPresented: $properties.showCamera, content: {
                    CameraView() { food in
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
}
