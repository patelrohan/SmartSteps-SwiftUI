import SwiftUI
import Playgrounds

struct ContentView: View {
    var body: some View {

        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    VStack{
                        HStack{
                            VStack(alignment: .leading) {
                                Label("Steps", systemImage: "figure.walk")
                                    .font(.title3.bold())
                                    .foregroundStyle(.pink)

                                Text("Avg: 10k Steps")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }.foregroundStyle(.tertiary)

                            Spacer()

                            Image(systemName: "chevron.right")
                                .foregroundStyle(.secondary)
                        }
                        .padding(.bottom, 12)

                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(.secondary)
                            .frame(height: 150)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))


                    VStack (alignment: .leading){
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
            .navigationTitle("Dashboard")
        }

    }
}

#Preview {
    ContentView()
}

#Playground {
    _ = 1 + 2
}
