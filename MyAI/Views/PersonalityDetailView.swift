import SwiftUI

struct PersonalityDetailView: View {
    @ObservedObject var viewModel: PersonalityViewModel

    var body: some View {
        VStack {
            Text(viewModel.personality.name)
                .font(.largeTitle)
                .padding()

            Text("Traits: \(viewModel.personality.traits.joined(separator: ", "))")
                .padding()

            Button(action: {
                viewModel.startTraining()
            }) {
                Text("Train Personality")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            Button(action: {
                viewModel.removeTrainingHistory()
            }) {
                Text("Clear Training History")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Personality Details")
    }
}