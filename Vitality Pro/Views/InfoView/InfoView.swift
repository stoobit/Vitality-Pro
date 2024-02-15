import SwiftUI

struct InfoView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section(content: {
                    Text("Many people around the world choose fast food because of its convenience and taste. However, fast food often lacks essential nutrients, potentially leading to an unbalanced diet and vitamin deficiency.")
                }, header: {
                    Label(title: { Text("What is vitamin deficiency?") }, icon: {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundStyle(Color.red)
                    })    
                })
                
                Section(content: {
                    Text("Preventing vitamin deficiency is straightforward. Incorporating a variety of vegetables and fruits into your regular diet can make a significant difference. This healthy practice, which doesn't demand much time, ensures your body receives the essential vitamins needed for proper functioning.")
                }, header: {
                    Label(title: { Text("What can you do about it?") }, icon: {
                        Image(systemName: "questionmark.circle.fill")
                            .foregroundStyle(Color.yellow)
                    })    
                })
                
                Section(content: {
                    Text("**Vitality Pro** makes it easy to monitor your daily vitamin intake. By capturing images of the fruits and vegetables you eat, the app automatically identifies and records their corresponding vitamin levels in *mg*. This not only provides valuable insights into your food intake but also helps you maintaining a healthy lifestyle. Since **Vitality Pro** focuses exclusively on fruits and vegetables, the app is suitable for meat eaters as well as vegetarians and vegans.")
                }, header: {
                    Label(title: { Text("How can this app help?") }, icon: {
                        Image(systemName: "app.badge.checkmark.fill")
                            .foregroundStyle(Color.green)
                    })    
                }, footer: {
                     Text("Please note that the amounts shown are based on averages and do not reflect the exact amount of vitamins you consume.There are also other vitamins, but they must be obtained from other sources such as sunlight, nuts or other products.")
                })
                
                Section(content: {
                    Link(destination: URL(string: "https://fdc.nal.usda.gov/index.html")!) {
                        Label("usda.gov", systemImage: "chart.bar.fill")
                    }
                    .foregroundStyle(.primary)
                    
                    Link(destination: URL(string: "https://www.aok.de/pk/magazin/")!) {
                        Label("aok.de", systemImage: "chart.bar.fill")
                    }
                    .foregroundStyle(.primary)
                }, header: {
                    Label(title: { Text("Sources of Information") }, icon: {
                        Image(systemName: "doc.text.magnifyingglass")
                            .foregroundStyle(Color.orange)
                    })  
                })
            }
            .environment(\.defaultMinListRowHeight, 55)
            .navigationTitle("About")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done", action: { dismiss() })
                }
            }
        }
    }
}
