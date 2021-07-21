//
//  HealthKitSetupAssistant.swift
//  HealthKitTest
//
//  Created by LeeHsss on 2021/07/20.
//

import HealthKitUI

class HealthKitSetUpAssistant {
    
    private enum HealthKitError : Error {
        case NotAvailableOnDevice
        case dataTypeNotAvailable
    }
    
    
    class func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Void) {
        
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, HealthKitError.NotAvailableOnDevice)
            return
        }
        
        guard let dateOfBirth = HKObjectType.characteristicType(forIdentifier: .dateOfBirth),
              let bloodType = HKObjectType.characteristicType(forIdentifier: .bloodType),
              let biologicalSex = HKObjectType.characteristicType(forIdentifier: .biologicalSex),
              let bodyMassIndex = HKObjectType.quantityType(forIdentifier: .bodyMassIndex),
              let height = HKObjectType.quantityType(forIdentifier: .height),
              let bodyMass = HKObjectType.quantityType(forIdentifier: .bodyMass),
              let activeEnergy = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned) else {
            
            completion(false, HealthKitError.dataTypeNotAvailable)
            return
        }
        
        let healthKitTypesToWrite: Set<HKSampleType> = [bodyMassIndex, activeEnergy, HKObjectType.workoutType()]
        let healthKitTypesToRead: Set<HKObjectType> = [dateOfBirth, bloodType, biologicalSex, height, bodyMass, HKObjectType.workoutType()]
        
        HKHealthStore().requestAuthorization(toShare: healthKitTypesToWrite, read: healthKitTypesToRead) { (success, error) in
            
            completion(success, error)
        }
    }
}
