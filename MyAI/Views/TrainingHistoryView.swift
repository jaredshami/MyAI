import SwiftUI

struct TrainingHistoryView: View {
    @ObservedObject var viewModel: TrainingViewModel
    var personality: AIPersonality

    var body: some View {
        VStack {
            Text("Training History for \(personality.name)")
                .font(.largeTitle)
                .padding()

            List(viewModel.trainingHistory) { trainingSession in
                VStack(alignment: .leading) {
                    Text("Session Date: \(trainingSession.date, formatter: dateFormatter)")
                    Text("Details: \(trainingSession.details)")
                }
            }
            .onAppear {
                viewModel.loadTrainingHistory(for: personality)
            }
        }
        .navigationTitle("Training History")
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
}

struct TrainingHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        let mockPersonality = AIPersonality(name: "Test Personality")
        let mockViewModel = TrainingViewModel()
        return TrainingHistoryView(viewModel: mockViewModel, personality: mockPersonality)
    }
}