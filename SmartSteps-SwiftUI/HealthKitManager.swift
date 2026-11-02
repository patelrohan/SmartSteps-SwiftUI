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

    func getStepCount() async {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: .now)
        let endDate = calendar.date(byAdding: .day, value: 1, to: today)!
        let startDate = calendar.date(byAdding: .day, value: -28, to: endDate)

        let queryPredicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let samplePredicate = HKSamplePredicate.quantitySample(type: HKQuantityType(.stepCount), predicate: queryPredicate)
        let stepsQuery = HKStatisticsCollectionQueryDescriptor(predicate: samplePredicate,
                                                               options: .cumulativeSum, anchorDate: endDate,
                                                               intervalComponents: .init(day: 1))
        let stepCounts = try! await stepsQuery.result(for: store)
    }

    func getDistanceData() async {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: .now)
        let endDate = calendar.date(byAdding: .day, value: 1, to: today)!
        let startDate = calendar.date(byAdding: .day, value: -28, to: endDate)

        let queryPredicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let samplePredicate = HKSamplePredicate.quantitySample(type: HKQuantityType(.distanceWalkingRunning), predicate: queryPredicate)
        let distanceQuery = HKStatisticsCollectionQueryDescriptor(predicate: samplePredicate,
                                                                  options: .cumulativeSum,
                                                                  anchorDate: endDate,
                                                                  intervalComponents: .init(day: 1))
        let distanceData = try! await distanceQuery.result(for: store)
    }


    func addMockData() async {

//        var mockData: [HKQuantitySample] = []
//
//        for i in 0..<30 {
//            let stepQuantity = HKQuantity(unit: .count(), doubleValue: .random(in: 4000...21000))
//            let distanceQuantity = HKQuantity(unit: .mile(), doubleValue: .random(in: 1...10))
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


