import SwiftUI
import AVFoundation

struct Example3View: View {
    let synthesizer = AVSpeechSynthesizer()
    let utterance = AVSpeechUtterance(string: "utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance")
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Press the button and hear AVSpeechSynthesizer say \"utterance\" on repeat while you turn on VoiceOver and move the focus around.")
            Text("AVAudioSession options is set to .mixWithOthers, so VoiceOver will be louder than AVSpeechSynthesizer if they are speaking at the same time.")
            Text("(Make sure your phone is not in silent mode.)")
            
            Button("Play") {
                synthesizer.speak(utterance)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationTitle("Example 3: .mixWithOthers")
        .onAppear {
            setupAudioSession()
        }
    }
    
    private func setupAudioSession() {
        try? AVAudioSession.sharedInstance().setCategory(.playback, options: [.mixWithOthers])
        try? AVAudioSession.sharedInstance().setActive(true)
    }
}

#Preview {
    Example3View()
}
