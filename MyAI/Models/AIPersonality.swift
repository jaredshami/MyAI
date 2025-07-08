import Foundation
import FirebaseFirestore

struct AIPersonality: Codable, Identifiable {
    @DocumentID var id: String? // Firestore document ID
    let name: String
    let traits: [String]
    let trainingData: [String: AnyCodable]
    let interactionHistory: [String: AnyCodable]
    let curiosityLevel: Int
    let selfTrainingEnabled: Bool
}
