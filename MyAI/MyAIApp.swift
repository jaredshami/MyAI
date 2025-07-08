import SwiftUI
import Firebase

@main
struct MyAIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AuthViewModel())
                .environmentObject(PersonalityViewModel())
                .environmentObject(TrainingViewModel())
        }
    }
}