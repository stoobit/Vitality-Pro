//
//  HealthKitViewModel.swift
//  TryHealthKit
//
//  Created by Jonathan Ricky Sandjaja on 07/10/22.
//

import Foundation
import HealthKit

@Observable class HealthKitViewModel {
    var isAuthorized = true
    var biologicalSex: HKBiologicalSex = .notSet

    var healthStore = HKHealthStore()
    let identifiers: [HKQuantityTypeIdentifier] = [
        .dietaryVitaminA,
        .dietaryVitaminC,
        .dietaryVitaminD,
        .dietaryVitaminE,
        .dietaryVitaminK,
        .dietaryVitaminB6,
        .dietaryVitaminB12,
        .dietaryRiboflavin,
        .dietaryNiacin,
        .dietaryBiotin,
        .dietaryThiamin,
        .dietaryPantothenicAcid,
        .dietaryFolate
    ]

    var data: [VitaminData] = []

    func healthRequest() {
        setupHealthRequest(healthStore: healthStore) {
            self.changeAuthorizationStatus()
            self.loadData()
        }
    }
}
