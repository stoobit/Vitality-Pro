import SwiftUI
import HealthKit

struct Vitamin: Identifiable, Hashable {
    var id: String
    
    init(
        title: LocalizedStringResource,
        alternative: LocalizedStringResource,
        identifier: HKQuantityTypeIdentifier,
        rdam: Double,
        rdaf: Double,
        description: LocalizedStringResource
    ) {
        self.id = String(localized: title)
        self.title = String(localized: title)
        self.alternative = String(localized: alternative)
        self.identifier = identifier
        self.rdam = rdam
        self.rdaf = rdaf
        self.description = String(localized: description)
    }
    
    var title: String
    var alternative: String
    var identifier: HKQuantityTypeIdentifier
    
    var rdam: Double
    var rdaf: Double
    
    var description: String
}
