import SwiftUI

struct HelpView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Available fruits/vegetables") {
                    ForEach(foods) { food in 
                        HStack {
                            Text(food.emoji)
                                .frame(width: 40, height: 40)
                                .font(.title3)
                                .background(.thickMaterial)
                                .clipShape(Circle())
                            
                            Text(food.title)
                                .padding(5)
                            
                            Spacer()
                            
                            if food.title == "Pepper" {
                                Text(String("Red/Green/Yellow").uppercased())
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            } else if food.title == "Apple" {
                                Text(String("Red/Green").uppercased())
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(4)
                    }
                }
            }
            .environment(\.defaultMinListRowHeight, 55)
            .scrollIndicators(.hidden)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done", action: { dismiss() })
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Text("Fruits & Vegetables")
                        .foregroundStyle(Color.primary)
                        .font(.headline.bold())
                }
            }
        }
    }
}
