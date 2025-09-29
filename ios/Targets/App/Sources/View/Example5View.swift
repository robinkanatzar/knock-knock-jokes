import SwiftUI
import AVFoundation

final class Example5Speaker {
    private let synthesizer = AVSpeechSynthesizer()

    init() {
        setupAudioSession()
    }

    func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        synthesizer.speak(utterance)
    }

    func stop() {
        _ = synthesizer.stopSpeaking(at: .immediate)
    }
    
    private func setupAudioSession() {
        try? AVAudioSession.sharedInstance().setCategory(.playback, options: [.mixWithOthers])
        try? AVAudioSession.sharedInstance().setActive(true)
    }
}

struct Example5View: View {
    @Environment(\.accessibilityVoiceOverEnabled) var isVoiceOverOn
    
    let utterance = "utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance, utterance"
    let speaker = Example5Speaker()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Press the button and hear AVSpeechSynthesizer say \"utterance\" on repeat while you turn on VoiceOver on and off.")
            Text("When VoiceOver is on, AVSpeechSynthesizer will stop.")
            Text("When VoiceOver is off, AVSpeechSynthesizer will speak.")
            Text("(Make sure your phone is not in silent mode.)")
            
            HStack {
                Button("Play") {
                    if !isVoiceOverOn {
                        speaker.speak(utterance)
                    }
                }
                .buttonStyle(.borderedProminent)
                Spacer()
            }
            
            Spacer()
            
            Text("VoiceOver is \(isVoiceOverOn ? "ON" : "OFF")")
        }
        .padding()
        .navigationTitle("Example 5: Is VoiceOver on?")
        .onChange(of: isVoiceOverOn) {
            if isVoiceOverOn {
                speaker.stop()
            }
        }
    }
}

#Preview {
    Example5View()
}
