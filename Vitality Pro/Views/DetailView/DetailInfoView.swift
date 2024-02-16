import SwiftUI

struct DetailInfoView: View {
    @AppStorage("biologicalsex") var biologicalFemale: Bool = true 
    @AppStorage("percentagegoal") var percentage: Double = 0.5
    
    var vitamin: Vitamin
    var emojis: [Emoji]
    
     let columns = [GridItem(.adaptive(minimum: 46))]

    var body: some View {
        Section("Scientific Name") {
            Text(vitamin.alternative)
        }
        
        Section("Food") {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(emojis) { emoji in
                    Text(emoji.description)
                        .frame(width: 50, height: 50)
                        .font(.title2)
                        .background(.thickMaterial)
                        .clipShape(Circle())
                }
            }
            .padding(.vertical, 7)
        }
        
        Section("Amount") {
           HStack {
               Text("Current Amount")
                   .fontWeight(.medium)
               Spacer()
               Text("\(String(amount.rounded(toPlaces: 2)))mg")
                   .foregroundStyle(Color.orange)
           }
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Minimum RDA")
                        .fontWeight(.medium)
                    
                    HStack(spacing: 5) {
                       Image(systemName: "gearshape.fill")
                           .font(.caption)
                           .foregroundStyle(Color.secondary)
                       
                       Text(biologicalFemale ? "Biological Female" : "Biological Male")
                           .font(.caption)
                           .foregroundStyle(Color.secondary)
                   }
                }
                .padding(.vertical, 6)
                
                Spacer()
                Text("\(String(biologicalFemale ? vitamin.rdaf : vitamin.rdam))mg")
                    .foregroundStyle(Color.orange)
            }
        }
        
        Section("Effect on the Body") {
            Text(vitamin.description)
                .padding(.vertical, 2.5)
        }
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
        
        return total
    }
    
}
