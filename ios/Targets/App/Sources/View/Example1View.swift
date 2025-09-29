import SwiftUI
import AVFoundation

struct Example1View: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Press the button and hear AVSpeechSynthesizer say \"Hey this is your phone speaking.\"")
            Text("(Make sure your phone is not in silent mode.)")
            
            Button("Play") {
                let synthesizer = AVSpeechSynthesizer()
                let utterance = AVSpeechUtterance(string: "Hey this is your phone speaking.")
                synthesizer.speak(utterance)
            }
        }
        .padding()
        .navigationTitle("Example 1")
    }
}

#Preview {
    Example1View()
}
