//
//  HealthDataListView.swift
//  SmartSteps-SwiftUI
//
//  Created by Rohan Patel on 10/28/26.
//

import SwiftUI

struct HealthDataListView: View {

    var metric: HealthMetricContext

    @State private var isShowingAddData = false
    @State private var addDataDate = Date.now
    @State private var valueToAdd: String = ""

    var body: some View {
        List(0..<25) { _ in
            HStack {
                Text(Date(), format: .dateTime.month().day().year())
                Spacer()
                Text(10000, format: .number.precision(.fractionLength(metric == .steps ? 0 : 2)))
            }
        }
        .navigationTitle(metric.title)
        .sheet(isPresented: $isShowingAddData) {
            addDataView
        }
        .toolbar {
            Button("Add Data", systemImage: "plus") {
                isShowingAddData = true
            }
        }
    }

    var addDataView: some View {
        NavigationStack {
            Form {
                // DatePicker(selection: $addDataDate, displayedComponents: .date, label: "Date")
                DatePicker("Date", selection: $addDataDate, displayedComponents: .date)

                HStack {
                    Text(metric.title)
                    Spacer()
                    TextField("Value", text: $valueToAdd)
                        .multilineTextAlignment(.trailing)
                        .frame(width: 160)
                        .keyboardType(metric == .steps ? .numberPad : .decimalPad)
                }
            }
            .navigationTitle(metric.title)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Data") {
                        // Add action later
                    }
                }

                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        isShowingAddData = false
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        HealthDataListView(metric: .weight)
    }
}
