import SwiftUI

struct CommunicationView: View {
    @State private var selectedPersonalities: [AIPersonality] = []
    @State private var message: String = ""
    @State private var conversation: [String] = []

    var body: some View {
        VStack {
            Text("Communication Room")
                .font(.largeTitle)
                .padding()

            List(selectedPersonalities) { personality in
                Text(personality.name)
            }

            TextField("Type your message...", text: $message)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: sendMessage) {
                Text("Send")
            }
            .padding()

            List(conversation, id: \.self) { msg in
                Text(msg)
            }
        }
        .navigationBarItems(trailing: Button("Add Personality") {
            // Logic to add a personality to the communication view
        })
    }

    private func sendMessage() {
        guard !message.isEmpty else { return }
        conversation.append("You: \(message)")
        // Logic to send the message to selected personalities and receive responses
        message = ""
    }
}

struct CommunicationView_Previews: PreviewProvider {
    static var previews: some View {
        CommunicationView()
    }
}