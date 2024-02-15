import SwiftUI
import Charts

struct DetailStatisticsView: View {
    @AppStorage("biologicalsex") var biologicalFemale: Bool = true 
    @AppStorage("percentagegoal") var percentage: Double = 0.5
    
    var vitamin: Vitamin
    var days: [String: Day]
    
    var body: some View {
        Chart {
            ForEach(weekdays, id: \.self) { day in
                let amount = getAmount(of: day)
                BarMark(
                    x: .value("Day", day),
                    y: .value("Amount", amount)
                )
                .clipShape(
                    UnevenRoundedRectangle(
                        topLeadingRadius: 12, 
                        bottomLeadingRadius: 0, 
                        bottomTrailingRadius: 0, 
                        topTrailingRadius: 12
                    )
                )
                .foregroundStyle(Date().getWeekday() == day ? Color.orange : Color.gray)
            }
            
            if biologicalFemale {
                RuleMark(y: .value("RDA Female Percentage", vitamin.rdaf * percentage))
                    .foregroundStyle(Color.green)
                    .cornerRadius(60)
                    .annotation(position: .top, alignment: .trailing, spacing: 5) {
                        Text("Daily Goal")
                            .font(.caption2)
                            .padding(.trailing, 5)
                    }
            } else {
                RuleMark(y: .value("RDA Male", vitamin.rdam * percentage))
                    .foregroundStyle(Color.green)
                    .cornerRadius(60)
                    .annotation(position: .top, alignment: .trailing, spacing: 5) {
                        Text("Daily Goal")
                            .font(.caption2)
                            .padding(.trailing, 5)
                    }
            }
        }
        .frame(height: 350)
        .frame(height: 360)
    }
    
    func getAmount(of weekday: String) -> Double {
        var value: Double = 0
        guard let amounts = days[weekday]?.amounts else { return 0 }
        
        for amount in amounts {
            if amount.vitamin == vitamin.title {
                value += amount.value
            }
        }
        
        return value
    }
    
}
