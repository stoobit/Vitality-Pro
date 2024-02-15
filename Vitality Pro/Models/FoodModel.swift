import Foundation

struct Food: Identifiable, Hashable {
    var id: String
    
    var title: String
    var emoji: String
    
    var vitamins: [String: Double] = [:]
    
    init(title: String, emoji: String, vitamins: [String : Double]) {
        self.id = title
        self.title = title
        self.emoji = emoji
        self.vitamins = vitamins
    }
}
