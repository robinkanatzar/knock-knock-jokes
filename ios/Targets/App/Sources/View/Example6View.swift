import SwiftUI
import AVFoundation

struct Example6View: View {
    let synthesizer = AVSpeechSynthesizer()
    let utterance = AVSpeechUtterance(string: "Knock knock.")
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Press the button and hear AVSpeechSynthesizer say \"Knock knock.\"")
            Text("(Make sure your phone is not in silent mode.)")
            
            HStack {
                Button("Tell me a joke.") {
                    synthesizer.speak(utterance)
                }
                .buttonStyle(.borderedProminent)
                Spacer()
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Example 6: ")
    }
}

#Preview {
    Example6View()
}
