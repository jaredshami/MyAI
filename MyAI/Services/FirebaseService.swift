import Firebase
import FirebaseAuth
import FirebaseFirestore

class FirebaseService {
    
    private let auth = Auth.auth()
    private let firestore = Firestore.firestore()
    
    // MARK: - Authentication
    
    func signUp(email: String, password: String, completion: @escaping (Result<FirebaseAuth.User, Error>) -> Void) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let user = result?.user else {
                completion(.failure(NSError(domain: "FirebaseService", code: -1, userInfo: [NSLocalizedDescriptionKey: "User creation failed."])))
                return
            }
            completion(.success(user))
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<FirebaseAuth.User, Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let user = result?.user else {
                completion(.failure(NSError(domain: "FirebaseService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Sign in failed."])))
                return
            }
            completion(.success(user))
        }
    }
    
    func signOut() throws {
        try auth.signOut()
    }
    
    // MARK: - Firestore Operations
    
    func saveAIPersonality(personality: AIPersonality, completion: @escaping (Result<Void, Error>) -> Void) {
        let data: [String: Any] = [
            "name": personality.name,
            "traits": personality.traits,
            "trainingData": personality.trainingData,
            "interactionHistory": personality.interactionHistory,
            "curiosityLevel": personality.curiosityLevel,
            "selfTrainingEnabled": personality.selfTrainingEnabled
        ]
        
        firestore.collection("aiPersonalities").addDocument(data: data) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func fetchAIPersonalities(completion: @escaping (Result<[AIPersonality], Error>) -> Void) {
        firestore.collection("aiPersonalities").getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let documents = snapshot?.documents else {
                completion(.success([]))
                return
            }
            let personalities = documents.compactMap { doc -> AIPersonality? in
                let data = doc.data()
                return AIPersonality(
                    name: data["name"] as? String ?? "",
                    traits: data["traits"] as? [String] ?? [],
                    trainingData: data["trainingData"] as? [String: Any] ?? [:],
                    interactionHistory: data["interactionHistory"] as? [String: Any] ?? [:],
                    curiosityLevel: data["curiosityLevel"] as? Int ?? 0,
                    selfTrainingEnabled: data["selfTrainingEnabled"] as? Bool ?? false
                )
            }
            completion(.success(personalities))
        }
    }
}
