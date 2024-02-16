import HealthKit
import SwiftUI

struct ContentView: View {
    @Environment(HealthKitViewModel.self) var healthViewModel
    
    @AppStorage("last opened") var date: Data = .init()
    @State var properties: PropertyModel = .init()
    
    var body: some View {
        @Bindable var properties = properties
        
        NavigationStack {
            DashboardView()
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
                .environment(properties)
        }
    }
    
    func add(food: Food) {
        for vitamin in food.vitamins {
            guard let identifier = vitamins.first(where: {
                $0.id == vitamin.key
            })?.identifier else { continue }
           
            guard let type = HKSampleType.quantityType(forIdentifier: identifier) else {
                return
            }
                
            let quantity = HKQuantity(
                unit: HKUnit.gramUnit(with: .milli),
                doubleValue: vitamin.value
            )
            
            let sample = HKQuantitySample(
                type: type, quantity: quantity, start: Date(), end: Date()
            )
                
            HKHealthStore().save(sample) { _, _ in
                healthViewModel.update()
            }
        }
    }
}
