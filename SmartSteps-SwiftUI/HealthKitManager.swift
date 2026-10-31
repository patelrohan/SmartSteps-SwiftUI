//
//  HealthKitManager.swift
//  SmartSteps-SwiftUI
//
//  Created by Rohan Patel on 10/29/26.
//

import Foundation
import HealthKit

@Observable class HealthKitManager {

    let store = HKHealthStore()
    let healthDataTypes: Set = [HKQuantityType(.stepCount), HKQuantityType(.distanceWalkingRunning)]

    func addMockData() async {

//        var mockData: [HKQuantitySample] = []
//
//        for i in 0..<30 {
//            let stepQuantity = HKQuantity(unit: .count(), doubleValue: .random(in: 4000...21000))
//            let distanceQuantity = HKQuantity(unit: .mile(), doubleValue: .random(in: 0...10))
//
//            let startDate = Calendar.current.date(byAdding: .day, value: -i, to: .now)!
//            let endDate = Calendar.current.date(byAdding: .day, value: -i, to: .now)!
//
//            let stepSample = HKQuantitySample(type: HKQuantityType(.stepCount), quantity: stepQuantity, start: startDate, end: endDate)
//            let distanceSample = HKQuantitySample(type: HKQuantityType(.distanceWalkingRunning), quantity: distanceQuantity, start: startDate, end: endDate)
//
//            mockData.append(stepSample)
//            mockData.append(distanceSample)
//        }
//
//        try! await store.save(mockData)
//        print("🔥 mock data written")
    }
}


