//
//  Step.swift
//  HealthKitTest
//
//  Created by LeeHsss on 2021/07/19.
//

import Foundation
import HealthKitUI

struct Step: Identifiable {
    let id = UUID()
    let count: Int
    let date: Date
}
