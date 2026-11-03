//
//  HealthMetric.swift
//  SmartSteps-SwiftUI
//
//  Created by Rohan Patel on 11/2/26.
//

import Foundation

struct HealthMetric: Identifiable{
    let id = UUID()
    let date: Date
    let value: Double
}
