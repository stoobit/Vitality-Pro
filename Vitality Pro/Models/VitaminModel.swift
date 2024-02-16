import SwiftUI
import HealthKit

struct Vitamin: Identifiable, Hashable {
    var id: String
    
    init(
        title: String,
        alternative: String,
        identifier: HKQuantityTypeIdentifier,
        rdam: Double,
        rdaf: Double,
        description: String
    ) {
        self.id = title
        self.title = title
        self.alternative = alternative
        self.identifier = identifier
        self.rdam = rdam
        self.rdaf = rdaf
        self.description = description
    }
    
    var title: String
    var alternative: String
    var identifier: HKQuantityTypeIdentifier
    
    var rdam: Double
    var rdaf: Double
    
    var description: String
}
