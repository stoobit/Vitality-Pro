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
    
    private var healthStore = HKHealthStore()
    
    init() {
        healthRequest()
    }
    
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
    ]
    
    func healthRequest() {
        setupHealthRequest(healthStore: healthStore) {
            self.changeAuthorizationStatus()
        }
    }
    
    func setupHealthRequest(healthStore: HKHealthStore, authorization: @escaping () -> Void) {
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
    
    func loadBiologicalSex() {
        do {
            biologicalSex = try healthStore.biologicalSex().biologicalSex
            if biologicalSex == .male || biologicalSex == .female {
                print("🟢 Biological Sex: ", biologicalSex == .male ? "male" : "female")
            }
        } catch {}
    }
    
    func changeAuthorizationStatus() {
        for identifier in identifiers {
            guard let type = HKObjectType.quantityType(forIdentifier: identifier) else {
                isAuthorized = false
                return
            }
                
            let status = healthStore.authorizationStatus(for: type)
            switch status {
            case .notDetermined:
                isAuthorized = false
                return
            case .sharingDenied:
                isAuthorized = false
                return
            case .sharingAuthorized:
                isAuthorized = true
            @unknown default:
                isAuthorized = false
                return
            }
        }
    }

    func readStepsTakenToday() {
        readStepCount(forToday: Date(), healthStore: healthStore) { step in
            if step != 0.0 {
                DispatchQueue.main.async {
//                    self.userStepCount = String(format: "%.0f", step)
                }
            }
        }
    }
    
    func readStepCount(forToday: Date, healthStore: HKHealthStore, completion: @escaping (Double) -> Void) {
        guard let stepQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return }
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            
            guard let result = result, let sum = result.sumQuantity() else {
                completion(0.0)
                return
            }
            
            completion(sum.doubleValue(for: HKUnit.count()))
        }
        
        healthStore.execute(query)
    }
}
