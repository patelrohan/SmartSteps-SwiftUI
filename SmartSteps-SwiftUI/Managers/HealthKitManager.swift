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
    let healthDataTypes: Set = [HKQuantityType(.stepCount), HKQuantityType(.bodyMass)]

    var stepData: [HealthMetric] = []
    var distanceData: [HealthMetric] = []

    func getStepCount() async {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: .now)
        let endDate = calendar.date(byAdding: .day, value: 1, to: today)!
        let startDate = calendar.date(byAdding: .day, value: -28, to: endDate)

        let queryPredicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let samplePredicate = HKSamplePredicate.quantitySample(type: HKQuantityType(.stepCount), predicate: queryPredicate)
        let sumOfStepsQuery = HKStatisticsCollectionQueryDescriptor(predicate: samplePredicate,
                                                               options: .cumulativeSum, anchorDate: endDate,
                                                               intervalComponents: .init(day: 1))

        do {
            let stepStatisticsCollection = try await sumOfStepsQuery.result(for: store)
            stepData = stepStatisticsCollection.statistics().map({ stepStatistic in
                let steps = stepStatistic.sumQuantity()?.doubleValue(for: .count()) ?? 0
                return HealthMetric(date: stepStatistic.startDate, value: steps)
            })
        } catch{

        }

        //simplified alternate version of map iteration

        /* var result: [HealthMetric] = []
        for statistic in stepStatisticsCollection.statistics() {
            let steps = statistic.sumQuantity()?.doubleValue(for: .count()) ?? 0
            result.append(HealthMetric(date: statistic.startDate, value: steps))
        }
        stepData = result */
    }

    func getWeightData() async {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: .now)
        let endDate = calendar.date(byAdding: .day, value: 1, to: today)!
        let startDate = calendar.date(byAdding: .day, value: -28, to: endDate)

        let queryPredicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let samplePredicate = HKSamplePredicate.quantitySample(type: HKQuantityType(.bodyMass), predicate: queryPredicate)
        let weightQuery = HKStatisticsCollectionQueryDescriptor(predicate: samplePredicate,
                                                                  options: .mostRecent,
                                                                  anchorDate: endDate,
                                                                  intervalComponents: .init(day: 1))

        do {
            let distanceStatisticsCollection = try await weightQuery.result(for: store)

            distanceData = distanceStatisticsCollection.statistics().map({ distanceStatistic in
                let distance = distanceStatistic.sumQuantity()?.doubleValue(for: .mile()) ?? 0
                return HealthMetric(date: distanceStatistic.startDate, value: distance)
            })
        } catch{

        }
    }


//    func addMockData() async {
//
//        var mockData: [HKQuantitySample] = []
//
//        for i in 0..<28 {
//            let stepQuantity = HKQuantity(unit: .count(), doubleValue: .random(in: 5000...20000))
//            let weightQuantity = HKQuantity(unit: .pound(), doubleValue: .random(in: (160 + Double(i/3)...165 + Double(i/3))))
//
//            let startDate = Calendar.current.date(byAdding: .day, value: -i, to: .now)!
//            let endDate = Calendar.current.date(byAdding: .day, value: -i, to: .now)!
//
//            let stepSample = HKQuantitySample(type: HKQuantityType(.stepCount), quantity: stepQuantity, start: startDate, end: endDate)
//            let weightSample = HKQuantitySample(type: HKQuantityType(.bodyMass), quantity: weightQuantity, start: startDate, end: endDate)
//
//            mockData.append(stepSample)
//            mockData.append(weightSample)
//        }
//
//        try! await store.save(mockData)
//        print("🔥 mock data written")
//    }
}


