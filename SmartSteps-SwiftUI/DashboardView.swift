import SwiftUI
import Playgrounds

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

                    VStack {
                        NavigationLink(value: selectedStat) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Label("Steps", systemImage: "figure.walk")
                                        .font(.title3.bold())
                                        .foregroundStyle(.pink)

                                    Text("Avg: 10k Steps")
                                        .font(.caption)
                                }

                                Spacer()

                                Image(systemName: "chevron.right")
                            }
                        }
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 12)

                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(.secondary)
                            .frame(height: 150)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))

                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Label("Averages", systemImage: "calendar")
                                .font(.title3.bold())
                                .foregroundStyle(.pink)

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
            .onAppear(perform: {
                isShowingPermissionScreen = !hasSeenPermissionScreen
            })
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
        .tint(isSteps ? .pink : .indigo)
    }
}

#Preview {
    DashboardView()
        .environment(HealthKitManager())
}

#Playground {
    _ = 1 + 2
}
