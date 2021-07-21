//
//  ProfileDataStore.swift
//  HealthKitTest
//
//  Created by LeeHsss on 2021/07/20.
//

import HealthKitUI

class ProfileDataStore {
    
    class func bindData() throws -> (age: Int, biologicalSex: HKBiologicalSex, bloodType: HKBloodType){
        let healthStore = HKHealthStore()
        
        do {
            let birthdayComponents = try healthStore.dateOfBirthComponents()
            let biologicalSex = try healthStore.biologicalSex()
            let bloodType = try healthStore.bloodType()
            
            let today = Date()
            let calendar = Calendar.current
            let todayDateComponents = calendar.dateComponents([.year], from: today)
            
            let thisYear = todayDateComponents.year!
            let age = thisYear - birthdayComponents.year!
            
            let unwrappedbiologicalSex = biologicalSex.biologicalSex
            let unwrappedbloodType = bloodType.bloodType

            return (age, unwrappedbiologicalSex, unwrappedbloodType)
        }
    }
    
    class func getRecentHeight(completion: @escaping (HKQuantitySample?, Error?) -> Void) {
        
        let sampleType = HKSampleType.quantityType(forIdentifier: .height)
        
        let predicate = HKQuery.predicateForSamples(withStart: Date.distantPast, end: Date(), options: .strictEndDate)
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        let SampleQuery = HKSampleQuery(sampleType: sampleType!, predicate: predicate, limit: 1, sortDescriptors: [sortDescriptor]) { (query, samples, error) in
            
            guard let testSample = samples, let mostRecentSample = testSample.first as? HKQuantitySample else {
                completion(nil, error)
                return
            }
            
            completion(mostRecentSample, nil)
        }
        HKHealthStore().execute(SampleQuery)
    }
    
    class func getRecentWeight(completion: @escaping (HKQuantitySample?, Error?) -> Void) {
        
        let sampleType = HKSampleType.quantityType(forIdentifier: .bodyMass)
        
        let predicate = HKQuery.predicateForSamples(withStart: Date.distantPast, end: Date(), options: .strictEndDate)
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        let SampleQuery = HKSampleQuery(sampleType: sampleType!, predicate: predicate, limit: 1, sortDescriptors: [sortDescriptor]) { (query, samples, error) in
            
            guard let testSample = samples, let mostRecentSample = testSample.first as? HKQuantitySample else {
                completion(nil, error)
                return
            }
            
            completion(mostRecentSample, nil)
        }
        HKHealthStore().execute(SampleQuery)
    }
}
