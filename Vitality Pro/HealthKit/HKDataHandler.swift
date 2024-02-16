//
//  HKDataHandler.swift
//  Vitality Pro
//
//  Created by Till Brügmann on 16.02.24.
//

import HealthKit

extension HealthKitViewModel {
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
