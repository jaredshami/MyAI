import Foundation

struct User {
    var id: String
    var email: String
    var displayName: String?
    var aiPersonalities: [AIPersonality]
    
    init(id: String, email: String, displayName: String? = nil, aiPersonalities: [AIPersonality] = []) {
        self.id = id
        self.email = email
        self.displayName = displayName
        self.aiPersonalities = aiPersonalities
    }
}