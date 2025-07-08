import Foundation

struct TrainingHistory: Codable {
    struct TrainingSession: Codable {
        let date: Date
        let duration: TimeInterval
        let domain: String
        let notes: String?
    }
    
    let sessions: [TrainingSession]
}