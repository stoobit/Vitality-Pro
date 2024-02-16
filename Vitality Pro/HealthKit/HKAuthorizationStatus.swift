//
//  HKAuthorizationStatus.swift
//  Vitality Pro
//
//  Created by Till Brügmann on 16.02.24.
//

import HealthKit

extension HealthKitViewModel {
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
}
