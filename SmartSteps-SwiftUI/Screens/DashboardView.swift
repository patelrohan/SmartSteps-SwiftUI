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

    var isSteps: Bool { selectedStat == .steps }

    var body: some View {

        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {

                    Picker("Selected Stat", selection: $selectedStat) {
                        ForEach(HealthMetricContext.allCases) { metric in
                            Text(metric.title)
                        }
                    }.pickerStyle(.segmented)

                    StepBarChart(selectedStat: selectedStat, stepData: hkManager.stepData)

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
                ChartMath.avgWeekdayStepsCount(for: hkManager.stepData)
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
}

#Preview {
    DashboardView()
        .environment(HealthKitManager())
}

#Playground {
    _ = 1 + 2
}
