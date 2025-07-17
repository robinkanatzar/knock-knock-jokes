//
//  JokeView.swift
//  Joke
//
//  Created by Robin Kanatzar on 7/17/25.
//

import SwiftUI
import AVFoundation
import Speech
import SharedKit

enum Status: String {
    case idle
    case speaking
    case listening
}

struct JokeView: View {
    @State private var status: Status = .idle
    @State private var speechHelper = SpeechHelper()
    
    @StateObject private var recognizer = SimpleSpeechRecognizer()
        
    var body: some View {
        VStack(spacing: 20) {
            Text("Status: \(status.rawValue)")
                .padding()
            
            Button("Start") {
                status = .speaking
                speechHelper.speak("Knock knock") {
                    status = .idle
                }
            }
            Button("Start listening") {
                status = .listening
                startListening()
            }
            .disabled(status == .speaking)
            Button("Stop listening") {
                stopListening()
            }
            .disabled(status != .listening)
            Text(recognizer.transcript)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
//            Button("Lettuce") {
//                status = .speaking
//                speechHelper.speak("lettuce") {
//                    status = .idle
//                }
//            }
//            Button("Punch line") {
//                status = .speaking
//                speechHelper.speak("Lettuce in, we're freezing out here!") {
//                    status = .idle
//                }
//            }
        }
        .onAppear {
            askUserFor(.microphoneAccess)
        }
        .onChange(of: recognizer.transcript) { value in
            if value.lowercased().contains("there") {
                stopListening()
                status = .speaking
                speechHelper.speak("lettuce") {
                    status = .idle
                }
            } else if value.lowercased().contains("lettuce who") {
                stopListening()
                status = .speaking
                speechHelper.speak("Lettuce in, we're freezing out here!") {
                    status = .idle
                }
            }
        }
    }
    
    func requestSpeechAuthorization() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            switch authStatus {
            case .authorized:
                print("Speech recognition authorized")
            default:
                print("Speech recognition not authorized")
            }
        }
    }
    
    func startListening() {
        status = .listening
        recognizer.transcript = ""
        recognizer.startListening()
    }
    
    func stopListening() {
        recognizer.stopListening()
        status = .idle
    }
}

#Preview {
    JokeView()
}

// MARK: -
import AVFoundation

class SpeechHelper: NSObject, AVSpeechSynthesizerDelegate {
    private let synthesizer = AVSpeechSynthesizer()
    private var onFinish: (() -> Void)?

    override init() {
        super.init()
        synthesizer.delegate = self
    }

    func speak(_ text: String, onFinish: @escaping () -> Void) {
        self.onFinish = onFinish
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speak(utterance)
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        onFinish?()
        onFinish = nil
    }
}
