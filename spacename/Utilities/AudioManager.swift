//
//  AudioManager.swift
//  spacename
//
//  Created by Noor Ahmed on 05/04/24.
//

import Foundation
import AVFoundation

class AudioManager: ObservableObject {
    private var audioPlayer: AVPlayer?
    @Published var isPlaying: Bool = false
    
    func selectAudio(sound: String) {
        if let url = URL(string: sound) {
            self.audioPlayer = AVPlayer(url: url)
            self.playAudio()
        }
    }
    
    func playAudio() {
        self.audioPlayer?.play()
        self.isPlaying = true
    }
    
    func pauseAudio() {
        self.audioPlayer?.pause()
        self.isPlaying = false
    }
    
}
