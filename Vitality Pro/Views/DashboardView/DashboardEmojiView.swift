import SwiftUI

struct DashboardEmojiView: View {
    var emojis: [Emoji]
    
    var body: some View {
        HStack {
            ForEach(0..<indices, id: \.self) { index in 
                Text(emojis[index].description)
                    .frame(width: 50, height: 50)
                    .font(.title2)
                    .background(.thinMaterial)
                    .clipShape(Circle())
            }
            
            if emojis.count > 3 {
                Text("\(emojis.count - 3)+")
                    .frame(width: 50, height: 50)
                    .font(.title3)
                    .background(.thinMaterial)
                    .clipShape(Circle())
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .bottomTrailing
        )
    }
    
    var indices: Int {
        if emojis.count < 4 {
            return emojis.count
        } else {
            return 3
        }
    }
}
