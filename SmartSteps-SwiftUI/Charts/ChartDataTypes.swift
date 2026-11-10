//
//  ChartDataTypes.swift
//  SmartSteps-SwiftUI
//
//  Created by Rohan Patel on 11/10/26.
//

import Foundation

struct WeekdayChartData: Identifiable {

    let id = UUID()
    let date: Date
    let value: Double
}
