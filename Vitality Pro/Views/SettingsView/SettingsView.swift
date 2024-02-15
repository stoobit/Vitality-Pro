import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    
    @AppStorage("biologicalsex") var biologicalFemale: Bool = true 
    @AppStorage("percentagegoal") var percentage: Double = 0.5
    
    let sexlabel = "The recommended vitamin amount differs for biological males and females."
    let percentagelabel = "Set a proportion of the minimum recommended daily amount as your daily goal."
    
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
                    Stepper(value: $percentage, in: 0.25...2, step: Double(0.05)) {
                        Text("\(String((percentage * 100).rounded(toPlaces: 2)))%")
                    }
                } footer: {
                    Label(percentagelabel, systemImage: "flag.fill")
                }
                
            }
            .environment(\.defaultMinListRowHeight, 55)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done", action: { dismiss() })
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
