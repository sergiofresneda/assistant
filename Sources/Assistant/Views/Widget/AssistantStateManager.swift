import Foundation
import Combine

final class AssistantStateManager: ObservableObject {
    enum State: String, Equatable, CaseIterable {
        case idle
        case listening
        case speaking
        case processing

        var imageName: String {
            switch self {
            case .idle:
                return "mic"
            case .listening:
                return "waveform.badge.microphone"
            case .speaking:
                return "waveform"
            case .processing:
                return "text.bubble.badge.clock.fill"
            }
        }
    }

    @Published private(set) var state: AssistantStateManager.State = .idle

    func startListening() {
        state = .listening
    }

    func stopListening() {
        state = .idle
    }

    func startSpeaking() {
        state = .speaking
    }

    func stopSpeaking() {
        state = .idle
    }

    func startProcessing() {
        state = .processing
    }

    func stopProcessing() {
        state = .idle
    }

    func next() {
        switch state {
        case .idle:
            startListening()
        case .listening:
            stopListening()
            startProcessing()
        case .speaking:
            stopSpeaking()
        case .processing:
            stopProcessing()
        }
    }
}
