//
//  StepBarChart.swift
//  SmartSteps-SwiftUI
//
//  Created by Rohan Patel on 11/9/26.
//

import SwiftUI
import Charts

struct StepBarChart: View {

    @State private var rawSelectedDate: Date?

    var selectedStat: HealthMetricContext
    var stepData: [HealthMetric]

    var avgStepCount: Double {
        guard !stepData.isEmpty else { return 0 }
        let totalSteps = stepData.reduce(0) { $0 + $1.value }
        return totalSteps/Double(stepData.count)
    }

    var selectedHealthMetric: HealthMetric? {
        guard let rawSelectedDate else { return nil }
        return stepData.first {
            Calendar.current.isDate(rawSelectedDate, inSameDayAs: $0.date)
        }
    }


    var body: some View {

        VStack {
            NavigationLink(value: selectedStat) {
                HStack {
                    VStack(alignment: .leading) {
                        Label("Steps", systemImage: "figure.walk")
                            .font(.title3.bold())
                            .foregroundStyle(.mint)

                        Text("Avg: \(Int(avgStepCount)) steps")
                            .font(.caption)
                    }

                    Spacer()

                    Image(systemName: "chevron.right")
                }
            }
            .foregroundStyle(.secondary)
            .padding(.bottom, 12)

            Chart{

                if let selectedHealthMetric {
                    RuleMark(x: .value("Selected Metric", selectedHealthMetric.date))
                        .offset(y: -10)
                        .foregroundStyle(Color.secondary.opacity(0.3))
                        .annotation(position: .top,
                                    spacing: 0,
                                    overflowResolution: .init(x: .fit(to: .chart),
                                                              y: .disabled)) {

                            annotationView
                        }

                }

                RuleMark(y: .value("Avg", avgStepCount))
                    .foregroundStyle(.gray)
                    .lineStyle(.init(lineWidth: 1, dash: [7]))

                ForEach(stepData) { steps in
                    BarMark(
                        x: .value("Date", steps.date),
                        y: .value("Steps",steps.value)
                    )
                    .opacity( (rawSelectedDate == nil || steps.date == selectedHealthMetric?.date) ? 1 : 0.3)
                }
            }
            .frame(height:150)

            .chartXSelection(value: $rawSelectedDate.animation(.easeInOut))

            .chartXAxis {
                AxisMarks {
                    AxisValueLabel(format: .dateTime.month(.defaultDigits).day())
                }
            }

            .chartYAxis {
                AxisMarks { value in
                    AxisGridLine()
                        .foregroundStyle(Color.secondary.opacity(0.7))

                    AxisValueLabel((value.as(Double.self) ?? 0).formatted(.number.notation(.compactName)))
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
        
    }

    var annotationView: some View {
        VStack(alignment: .leading) {
            Text(selectedHealthMetric?.date ?? .now,
                 format: .dateTime.weekday(.abbreviated).month(.abbreviated).day())
            .font(.footnote.bold())
            .foregroundStyle(.secondary)

            //Text(selectedHealthMetric?.value ?? 0, format: .number.precision(.fractionLength(0)))
            Text("\(Int(selectedHealthMetric?.value ?? 0))")
                .font(.subheadline)
                .foregroundStyle(.mint)
        }
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 4)
            .fill(Color(.secondarySystemBackground)))
        .shadow(color: .secondary.opacity(0.3), radius: 2, x: 1, y: 1)
    }
}

#Preview {
    StepBarChart(selectedStat: .steps, stepData: HealthMetric.mockData)
}
