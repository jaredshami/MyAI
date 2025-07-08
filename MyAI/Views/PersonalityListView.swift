import SwiftUI

struct PersonalityListView: View {
    @ObservedObject var personalityViewModel: PersonalityViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(personalityViewModel.personalities) { personality in
                    NavigationLink(destination: PersonalityDetailView(personality: personality)) {
                        Text(personality.name)
                    }
                }
            }
            .navigationTitle("AI Personalities")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        personalityViewModel.addNewPersonality()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}