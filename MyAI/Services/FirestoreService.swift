import FirebaseFirestore

class FirestoreService {
    private let db = Firestore.firestore()

    // Function to add a new AI personality to Firestore
    func addAIPersonality(personality: AIPersonality, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            let _ = try db.collection("aiPersonalities").addDocument(from: personality)
            completion(.success(()))
        } catch let error {
            completion(.failure(error))
        }
    }

    // Function to fetch all AI personalities for a user
    func fetchAIPersonalities(for userId: String, completion: @escaping (Result<[AIPersonality], Error>) -> Void) {
        db.collection("aiPersonalities")
            .whereField("userId", isEqualTo: userId)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    let personalities = querySnapshot?.documents.compactMap { document -> AIPersonality? in
                        try? document.data(as: AIPersonality.self)
                    } ?? []
                    completion(.success(personalities))
                }
            }
    }

    // Function to update an AI personality
    func updateAIPersonality(personality: AIPersonality, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let personalityId = personality.id else {
            completion(.failure(NSError(domain: "FirestoreService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Personality ID is missing."])))
            return
        }
        
        do {
            try db.collection("aiPersonalities").document(personalityId).setData(from: personality)
            completion(.success(()))
        } catch let error {
            completion(.failure(error))
        }
    }

    // Function to delete an AI personality
    func deleteAIPersonality(personalityId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection("aiPersonalities").document(personalityId).delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}