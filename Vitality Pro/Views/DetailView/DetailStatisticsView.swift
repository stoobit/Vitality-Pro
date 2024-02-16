import Charts
import SwiftUI

struct DetailStatisticsView: View {
    @Environment(HealthKitViewModel.self) var healthViewModel
    
    @AppStorage("biologicalsex") var biologicalFemale: Bool = true
    @AppStorage("percentagegoal") var percentage: Double = 0.5
    
    var vitamin: Vitamin
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
                    .foregroundStyle(Color.primary)
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
                            topLeadingRadius: 7,
                            bottomLeadingRadius: 0,
                            bottomTrailingRadius: 0,
                            topTrailingRadius: 7
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
                        .foregroundStyle(Color.primary)
                        .cornerRadius(60)
                } else {
                    RuleMark(y: .value("RDA Male", vitamin.rdam))
                        .foregroundStyle(Color.primary)
                        .cornerRadius(60)
                }
            }
            .chartYAxisLabel("mg", position: .bottom)
            .frame(height: 350)
        }
        .padding(.vertical, 5)
    }
    
    func getAmount(of weekday: String) -> Double {
        guard let vitamin = healthViewModel.data.first(where: {
            $0.id == vitamin.identifier
        }) else { return 0 }
        
        guard let day = vitamin.days.first(where: {
            $0.date.getWeekday() == weekday
        }) else { return 0 }
        
        return day.amount
    }
}
