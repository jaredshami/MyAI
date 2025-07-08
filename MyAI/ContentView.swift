import SwiftUI

struct ContentView: View {
    @State private var isAuthenticated = false

    var body: some View {
        NavigationView {
            if isAuthenticated {
                PersonalityListView()
            } else {
                AuthenticationView(isAuthenticated: $isAuthenticated)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    ContentView()
}