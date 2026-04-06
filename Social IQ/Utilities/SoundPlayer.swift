//
//  SoundPlayer.swift
//  Social IQ
//

import AudioToolbox
import Foundation

enum SoundPlayer {
    static func play(_ sound: Sound) {
        guard let url = Bundle.main.url(forResource: sound.filename, withExtension: "wav") else { return }
        var soundID: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(url as CFURL, &soundID)
        AudioServicesPlaySystemSound(soundID)
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
    }
}
