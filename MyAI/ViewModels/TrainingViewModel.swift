import Foundation
import Firebase

class TrainingViewModel: ObservableObject {
    @Published var aiPersonalities: [AIPersonality] = []
    @Published var trainingHistory: [TrainingHistory] = []
    
    private var firestoreService: FirestoreService
    private var mlService: MLService
    
    init(firestoreService: FirestoreService = FirestoreService(), mlService: MLService = MLService()) {
        self.firestoreService = firestoreService
        self.mlService = mlService
        fetchAITrainingData()
    }
    
    func fetchAITrainingData() {
        firestoreService.fetchTrainingData { [weak self] result in
            switch result {
            case .success(let data):
                self?.aiPersonalities = data.personalities
                self?.trainingHistory = data.history
            case .failure(let error):
                print("Error fetching training data: \(error)")
            }
        }
    }
    
    func trainAI(personality: AIPersonality, with data: [String: Any]) {
        mlService.train(personality: personality, with: data) { [weak self] success in
            if success {
                self?.updateTrainingHistory(for: personality)
            } else {
                print("Training failed for personality: \(personality.name)")
            }
        }
    }
    
    private func updateTrainingHistory(for personality: AIPersonality) {
        let newEntry = TrainingHistory(personalityID: personality.id, date: Date(), details: "Trained with new data.")
        trainingHistory.append(newEntry)
        firestoreService.saveTrainingHistory(newEntry)
    }
    
    func selfTrain(personality: AIPersonality) {
        mlService.selfTrain(personality: personality) { [weak self] success in
            if success {
                self?.updateTrainingHistory(for: personality)
            } else {
                print("Self-training failed for personality: \(personality.name)")
            }
        }
    }
}