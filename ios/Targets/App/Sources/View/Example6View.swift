import SwiftUI
import AVFoundation

struct Example6View: View {
    let synthesizer = AVSpeechSynthesizer()
    let utterance = AVSpeechUtterance(string: "Hey this is your phone speaking.")
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Press the button and hear AVSpeechSynthesizer say \"Hey this is your phone speaking.\"")
            Text("(Make sure your phone is not in silent mode.)")
            
            HStack {
                Button("Play") {
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
