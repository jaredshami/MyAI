import Foundation
import FirebaseAuth
import Combine

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var user: User?
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()

    init() {
        checkCurrentUser()
    }

    func checkCurrentUser() {
        if let currentUser = Auth.auth().currentUser,
           let email = currentUser.email {
            self.user = User(id: currentUser.uid, email: email)
            self.isAuthenticated = true
        } else {
            self.isAuthenticated = false
        }
    }

    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
                return
            }
            self?.checkCurrentUser()
        }
    }

    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
                return
            }
            self?.checkCurrentUser()
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            self.user = nil
            self.isAuthenticated = false
        } catch let signOutError as NSError {
            self.errorMessage = signOutError.localizedDescription
        }
    }
}