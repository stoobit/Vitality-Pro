import Foundation

struct Amount: Codable, Equatable {
    init(vitamin: String, value: Double) {
        self.vitamin = vitamin
        self.value = value
    }
    
    var vitamin: String
    var value: Double
}

