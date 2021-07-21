//
//  TestView.swift
//  HealthKitTest
//
//  Created by LeeHsss on 2021/07/20.
//

import SwiftUI
import UIKit
import HealthKitUI


struct TestView: View {
    @State private var message: String = "Get Data"
    @State private var getWeightMessage: String = "Get Weight"
    var body: some View {
        VStack {
            Button("Execute Authorization") {
                HealthKitSetUpAssistant.authorizeHealthKit { (success, error) in
                    
                    guard success else {
                        return
                    }
                    
                    print("HelathKit SuccessFully Authorized.")
                }
            }
            Spacer().frame(height:50)
            
            Button(message) {
                do {
                    let data = try ProfileDataStore.bindData()
                    
                    let profile = Profile(
                        age: data.age,
                        biologicalSex: data.biologicalSex,
                        bloodType: data.bloodType
                    )
                
                    print(profile.age!)
                    
                    if(profile.biologicalSex == HKBiologicalSex.male) {
                        print("male")
                    }
                    
                    if(profile.bloodType == HKBloodType.aPositive){
                        print("A+")
                    }
                
                } catch let error {
                    print("\(error)")
                }
            }
            
            Button(getWeightMessage) {
                ProfileDataStore.getRecentHeight { (result, error) in
                    
                    let heightmeters = result!.quantity.doubleValue(for: HKUnit.meter())
                    
                    let heightCentimeters = heightmeters * 100
                    print("\(heightCentimeters)")
                    getWeightMessage = "\(heightCentimeters)"
                }
            }
            
            Button("Get Weight") {
                ProfileDataStore.getRecentWeight { (result, error) in
                    
                    let weight = result!.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
                    print("\(weight)")
                }
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
