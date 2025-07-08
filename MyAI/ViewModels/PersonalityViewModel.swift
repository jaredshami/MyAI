import Foundation
import Firebase

class PersonalityViewModel: ObservableObject {
    @Published var personalities: [AIPersonality] = []
    
    private var firestoreService = FirestoreService()
    
    func createPersonality(name: String) {
        let newPersonality = AIPersonality(name: name)
        personalities.append(newPersonality)
        firestoreService.savePersonality(newPersonality)
    }
    
    func updatePersonality(_ personality: AIPersonality) {
        if let index = personalities.firstIndex(where: { $0.id == personality.id }) {
            personalities[index] = personality
            firestoreService.updatePersonality(personality)
        }
    }
    
    func removePersonality(_ personality: AIPersonality) {
        personalities.removeAll { $0.id == personality.id }
        firestoreService.deletePersonality(personality)
    }
    
    func loadPersonalities() {
        firestoreService.fetchPersonalities { [weak self] fetchedPersonalities in
            self?.personalities = fetchedPersonalities
        }
    }
    
    func trainPersonality(_ personality: AIPersonality, with data: TrainingHistory) {
        personality.train(with: data)
        firestoreService.updatePersonality(personality)
    }
    
    func invitePersonalityToCommunication(_ personality: AIPersonality) {
        // Logic to invite another personality into the communication view
    }
}