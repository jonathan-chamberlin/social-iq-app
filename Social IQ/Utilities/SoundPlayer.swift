//
//  SoundPlayer.swift
//  Social IQ
//

import AVFoundation
import Foundation

enum SoundPlayer {
    private static var player: AVAudioPlayer?

    static func play(_ sound: Sound) {
        guard let url = Bundle.main.url(forResource: sound.filename, withExtension: "wav") else { return }
        player = try? AVAudioPlayer(contentsOf: url)
        player?.volume = sound.volume
        player?.play()
    }

    enum Sound {
        case correctAnswer
        case wrongAnswer
        case lessonComplete

        var filename: String {
            switch self {
            case .correctAnswer: "correct-answer"
            case .wrongAnswer: "wrong-answer"
            case .lessonComplete: "lesson-complete"
            }
        }

        var volume: Float {
            switch self {
            case .wrongAnswer: 0.8
            default: 1.0
            }
        }
    }
}
