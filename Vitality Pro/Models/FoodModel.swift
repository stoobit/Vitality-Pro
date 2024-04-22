import Foundation

struct Food: Identifiable, Hashable {
    var id: String
    
    var title: String
    var emoji: String
    
    var vitamins: [String: Double] = [:]
    
    init(
        title: LocalizedStringResource,
        emoji: String,
        vitamins: [String: Double]
    ) {
        self.id = String(localized: title)
        self.title = String(localized: title)
        self.emoji = emoji
        self.vitamins = vitamins
    }
}
