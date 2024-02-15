import Foundation

struct Emoji: Identifiable, Hashable {
    let id = UUID()
    
    var description: String
    var value: Double
}
