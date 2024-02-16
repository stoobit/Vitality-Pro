//
//  HKHealthRequest.swift
//  Vitality Pro
//
//  Created by Till Brügmann on 16.02.24.
//

import HealthKit

extension HealthKitViewModel {
    func setupHealthRequest(
        healthStore: HKHealthStore, authorization: @escaping () -> Void
    ) {
        var shares: Set<HKSampleType> = []
        for identifier in identifiers {
            guard let sample = HKSampleType.quantityType(forIdentifier: identifier) else {
                continue
            }
            
            shares.insert(sample)
        }
        
        var reads: Set<HKObjectType> = []
        for identifier in identifiers {
            guard let sample = HKSampleType.quantityType(forIdentifier: identifier) else {
                continue
            }
            
            reads.insert(sample)
        }
        
        reads.insert(HKObjectType.characteristicType(forIdentifier: .biologicalSex)!)
        if HKHealthStore.isHealthDataAvailable() {
            healthStore.requestAuthorization(toShare: shares, read: reads) { success, _ in
                if success {
                    self.loadBiologicalSex()
                    authorization()
                }
            }
        }
        
        authorization()
    }
}
