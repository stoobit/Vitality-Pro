import SwiftUI

struct Vitamin: Identifiable, Hashable {
    var id: String
    
    init(
        title: String,
        alternative: String,
        rdam: Double,
        rdaf: Double,
        description: String
    ) {
        self.id = title
        self.title = title
        self.alternative = alternative
        self.rdam = rdam
        self.rdaf = rdaf
        self.description = description
    }
    
    var title: String
    var alternative: String
    
    var rdam: Double
    var rdaf: Double
    
    var description: String
}
