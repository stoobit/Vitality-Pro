import SwiftUI

struct DashboardCardView: View {
    @AppStorage("biologicalsex") var biologicalFemale: Bool = true 
    @AppStorage("percentagegoal") var percentage: Double = 0.5
    
    @State var showDetail: Bool = false
    var vitamin: Vitamin
    
    var body: some View {
        Button(action: { showDetail.toggle() }) {
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .foregroundStyle(.background)
                
                RoundedRectangle(cornerRadius: 18)
                    .stroke(.ultraThickMaterial, lineWidth: 3)
                
                VStack(alignment: .leading) {
                    Text(vitamin.title)
                        .font(.title.bold())
                        .foregroundStyle(Color.primary)
                    
                    Text(vitamin.alternative.uppercased())
                        .font(.callout)
                        .foregroundStyle(Color.secondary)
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .topLeading
                )
                .padding(15)
                
                DashboardEmojiView(emojis: emojis)
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .bottomTrailing
                    )
                    .padding(15)
                
                Label("Detail", systemImage: "text.magnifyingglass")
                    .labelStyle(.iconOnly)
                    .font(.title2)
                    .fontWeight(.medium)
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .bottomLeading
                    )
                    .padding(15)
                ZStack {
                    Gauge(value: amount, in: 0...gauge(), label: {})
                        .gaugeStyle(.accessoryCircular)
                        .tint(.orange)
                        .overlay {
                            Text(percentageDisplay())
                                .foregroundStyle(Color.secondary)
                                .font(.caption2)
                                .offset(y: 32)
                        }
                    
                    if goodAmount() {
                        Image(systemName: "flag.fill")
                            .foregroundStyle(Color.green)
                    } else {
                        Image(systemName: "flag.fill")
                            .foregroundStyle(Color.orange.tertiary)
                    }
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .topTrailing
                )
                .padding(15)
                
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 200)
        .sheet(isPresented: $showDetail, content: {
            DetailView(vitamin: vitamin, emojis: emojis)
                .scrollIndicators(.never)
        })
    }
    
    var emojis: [Emoji] {
        var emojis: [Emoji] = []
        
        for food in foods {
            for containedVitamin in food.vitamins {
                if containedVitamin.key == vitamin.title {
                    emojis.append(Emoji(
                        description: food.emoji, 
                        value: food.vitamins[vitamin.title] ?? 0
                    ))
                }
            }
        }
        
        return emojis.sorted(using: SortDescriptor(\.value, order: .reverse))
    }
    
    var amount: Double {
//        guard let day = days[Date().getWeekday()] else { return 0 }
//        let amounts = day.amounts
//            .filter { $0.vitamin == vitamin.title }
//            .map(\.value)
//        
        var total: Double = 0 
//        for value in amounts {
//            total += value
//        }
//        
        return total
    }
    
    func goodAmount() -> Bool{
        if biologicalFemale {
            if amount < vitamin.rdaf * percentage {
                return false 
            } else {
                return true 
            }
        } else {
            if amount < vitamin.rdam * percentage {
                return false 
            } else {
                return true 
            }
        }
    }
    
    func gauge() -> Double {
        if biologicalFemale {
            return vitamin.rdaf * percentage
        } else {
            return vitamin.rdam * percentage
        }
    }  
    
    func percentageDisplay() -> String {
        var value: Double = .zero
        
        if biologicalFemale { 
            value = amount / vitamin.rdaf
        } else {
             value = amount / vitamin.rdam
        }
        
        if value < percentage {
            return "\(String((value * 100).rounded(toPlaces: 1)))%"
        } else {
            return "+\(String((percentage * 100).rounded(toPlaces: 1)))%"
        }
    }
    
    
}
