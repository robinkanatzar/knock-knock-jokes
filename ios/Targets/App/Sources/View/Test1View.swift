//
//  Test1View.swift
//  Joke
//
//  Created by Robin Kanatzar on 9/11/25.
//

import AVFoundation

// MARK: - Speaker
/*
 Audio session: choose .playback to play over Silent mode; use .duckOthers or .mixWithOthers to coexist with other audio.
 Interruptions: observe AVAudioSession.interruptionNotification to pause/resume gracefully.
 Accessibility: if VoiceOver users are your target, consider posting important messages via UIAccessibility.post(.announcement, argument: ...) so it respects their settings.
 
 1. VoiceOver owns the system TTS (text to speech) channel
 - VoiceOver speech runs through a special audio category/session under the hood.
 - When VoiceOver is speaking, the system automatically ducks or queues any accessibility announcements you post with UIAccessibility.post(...).
 */
final class Speaker: NSObject, AVSpeechSynthesizerDelegate {
    private let synthesizer = AVSpeechSynthesizer()

    override init() {
        super.init()

        synthesizer.delegate = self
        try? AVAudioSession.sharedInstance().setCategory(.playback, options: [.duckOthers, .mixWithOthers])
        try? AVAudioSession.sharedInstance().setActive(true)
    }

    func speak(_ text: String, locale: String = "en-US") {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: locale) // e.g. "en-US", "fr-FR"
        utterance.rate  = AVSpeechUtteranceDefaultSpeechRate       // 0.0 ... 1.0 (use the provided constants)
        utterance.pitchMultiplier = 1.0                            // 0.5 ... 2.0
        utterance.preUtteranceDelay = 0.0
        utterance.postUtteranceDelay = 0.1
        synthesizer.speak(utterance)
    }

    func stop(immediately: Bool = false) {
        _ = synthesizer.stopSpeaking(at: immediately ? .immediate : .word)
    }
}


import SwiftUI

// MARK: - Test1View
struct Test1View: View {
    @State private var speaker = Speaker()

        var body: some View {
            VStack(spacing: 16) {
        
                Button("Speak with AVSpeechSynthesizer") {
                    speaker.speak("Hello! I can talk on my own using AVSpeechSynthesizer. This is an extremely long test so I can use VoiceOver at the same time and see what happens. Blah blah blah. Testing testing 1, 2, 3.")
                }
                Button("Stop AVSpeechSynthesizer") {
                    speaker.stop()
                }
//                Button("Speak Accessibility Announcement") {
//                    UIAccessibility.post(notification: .announcement, argument: "Hello! This is an accessibility announcement.")
//                }
            }
            .padding()
        }
}

#Preview {
    Test1View()
}
