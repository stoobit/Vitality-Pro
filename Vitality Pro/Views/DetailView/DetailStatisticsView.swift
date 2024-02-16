import Charts
import SwiftUI

struct DetailStatisticsView: View {
    @AppStorage("biologicalsex") var biologicalFemale: Bool = true
    @AppStorage("percentagegoal") var percentage: Double = 0.5
    
    var vitamin: Vitamin
    var days: [String: Day]
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                RoundedRectangle(cornerRadius: 60)
                    .foregroundStyle(Color.green)
                    .frame(width: 15, height: 2)
                Text("Daily Goal")
                
                Spacer()
                
                RoundedRectangle(cornerRadius: 60)
                    .foregroundStyle(Color.orange)
                    .frame(width: 15, height: 2)
                Text("RDA")
                
                Spacer()
            }
            .padding(.bottom, 30)
            
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
                    RuleMark(y: .value("RDA Proportion Female", vitamin.rdaf * percentage))
                        .foregroundStyle(Color.green)
                        .cornerRadius(60)
                } else {
                    RuleMark(y: .value("RDA Proportion Male", vitamin.rdam * percentage))
                        .foregroundStyle(Color.green)
                        .cornerRadius(60)
                }
                
                if biologicalFemale {
                    RuleMark(y: .value("RDA Female", vitamin.rdaf))
                        .foregroundStyle(Color.orange)
                        .cornerRadius(60)
                } else {
                    RuleMark(y: .value("RDA Male", vitamin.rdam))
                        .foregroundStyle(Color.orange)
                        .cornerRadius(60)
                }
            }
            .frame(height: 350)
        }
        .padding(.vertical, 5)
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

#Preview {
    Form {
        DetailStatisticsView(vitamin: vitamins[2], days: [:])
    }
}
