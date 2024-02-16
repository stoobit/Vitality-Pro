//
//  HKDataHandler.swift
//  Vitality Pro
//
//  Created by Till Brügmann on 16.02.24.
//

import HealthKit

extension HealthKitViewModel {
    func loadData() {
        for identifier in self.identifiers {
            data.append(VitaminData(id: identifier))
        }
        
        let dates = dates()
        for date in dates {
            let calendar = Calendar.current
            
            let start = calendar.startOfDay(for: date)
            guard let end = calendar.date(byAdding: .day, value: 1, to: start) else {
                continue
            }
            
            for identifier in self.identifiers {
                guard let index = data.firstIndex(where: { $0.id == identifier }) else {
                    return
                }
                
                loadVitamin(with: identifier, start: start, end: end) { value in
                    self.data[index].days.append(Day(date: start, amount: value))
                }
            }
        }
    }
    
    func loadVitamin(
        with id: HKQuantityTypeIdentifier,
        start: Date,
        end: Date,
        completion: @escaping (Double) -> Void
    ) {
        let type = HKQuantityType(id)
        let predicate = HKQuery.predicateForSamples(
            withStart: start, end: end, options: .strictStartDate
        )
        
        let query = HKStatisticsQuery(
            quantityType: type, quantitySamplePredicate: predicate, options: .cumulativeSum
        ) { _, result, _ in
            
            guard let result = result, let sum = result.sumQuantity() else {
                completion(0)
                return
            }
                
            let unit = HKUnit.gramUnit(with: HKMetricPrefix.milli)
            completion(sum.doubleValue(for: unit).rounded(toPlaces: 2))
        }
        
        healthStore.execute(query)
    }
    
    func dates() -> [Date] {
        var week = [Date]()
        var calendar = Calendar.autoupdatingCurrent
        calendar.firstWeekday = 2
        
        let today = calendar.startOfDay(for: Date())
        
        if let weekInterval = calendar.dateInterval(of: .weekOfYear, for: today) {
            for i in 0 ... 6 {
                if let day = calendar.date(byAdding: .day, value: i, to: weekInterval.start) {
                    week += [day]
                }
            }
        }
        
        return week
    }
}
