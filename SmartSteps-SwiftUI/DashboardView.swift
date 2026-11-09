import SwiftUI
import Playgrounds
import Charts

enum HealthMetricContext: CaseIterable, Identifiable {
    case steps, weight

    var id: Self { self }

    var title: String {
        switch self {
        case .steps:
            return "Steps"

        case .weight:
            return "Weight"
        }
    }
}

struct DashboardView: View {

    @AppStorage("hasSeenPermissionScreen") private var hasSeenPermissionScreen = false

    @Environment(HealthKitManager.self) private var hkManager

    @State private var isShowingPermissionScreen = false
    @State private var selectedStat: HealthMetricContext = .steps
    @State private var rawSelectedDate: Date?

    var isSteps: Bool { selectedStat == .steps }

    var avgStepCount: Double {
        guard !hkManager.stepData.isEmpty else { return 0 }
        let totalSteps = hkManager.stepData.reduce(0) { $0 + $1.value }
        return totalSteps/Double(hkManager.stepData.count)
    }

    var selectedHealthMetric: HealthMetric? {
        guard let rawSelectedDate else { return nil }
        return hkManager.stepData.first {
            Calendar.current.isDate(rawSelectedDate, inSameDayAs: $0.date)
        }
    }

    var body: some View {

        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {

                    Picker("Selected Stat", selection: $selectedStat) {
                        ForEach(HealthMetricContext.allCases) { metric in
                            Text(metric.title)
                        }
                    }.pickerStyle(.segmented)

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

                            ForEach(hkManager.stepData) { steps in
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

                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Label("Averages", systemImage: "calendar")
                                .font(.title3.bold())
                                .foregroundStyle(.mint)

                            Text("Last 28 Days")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }.foregroundStyle(.tertiary)

                        Spacer()
                            .padding(.bottom, 12)

                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(.secondary)
                            .frame(height: 250)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
                }
            }
            .padding()
            .task {
                await hkManager.getStepCount()
                isShowingPermissionScreen = !hasSeenPermissionScreen
                //await hkManager.addMockData()
            }
            .navigationTitle("Dashboard")
            .navigationDestination(for: HealthMetricContext.self) { metric in
                HealthDataListView(metric: metric)
            }
            .sheet(isPresented: $isShowingPermissionScreen) {
                //TODO: Fetch health data on dismiss
            } content: {
                HealthKitPermissionView(hasSeenHealthKitPermissionView: $hasSeenPermissionScreen)
            }

        }
        .tint(isSteps ? .mint : .indigo)
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
    DashboardView()
        .environment(HealthKitManager())
}

#Playground {
    _ = 1 + 2
}
