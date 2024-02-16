//
//  HealthKitModels.swift
//  Vitality Pro
//
//  Created by Till Brügmann on 16.02.24.
//

import Foundation
import HealthKit

struct VitaminData: Identifiable {
    var id: HKQuantityTypeIdentifier
    var days: [Day] = []
}

struct Day: Identifiable {
    let id = UUID()
    
    var date: Date
    var amount: Double = 0
}
