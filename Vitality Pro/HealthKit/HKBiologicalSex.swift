//
//  HKBiologicalSex.swift
//  Vitality Pro
//
//  Created by Till Brügmann on 16.02.24.
//

import HealthKit

extension HealthKitViewModel {
    func loadBiologicalSex() {
        do {
            biologicalSex = try healthStore.biologicalSex().biologicalSex
            if biologicalSex == .male || biologicalSex == .female {
                print("🟢 Biological Sex: ", biologicalSex == .male ? "male" : "female")
            } else {
                print("🟡 Biological Sex: ", "nil")
            }
        } catch {
            print("🔴 Biological Sex: ", "error")
        }
    }
}
