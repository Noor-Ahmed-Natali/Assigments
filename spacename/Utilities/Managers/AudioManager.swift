//
//  AudioManager.swift
//  spacename
//
//  Created by Noor Ahmed on 05/04/24.
//

import Foundation
import AVFoundation

class AudioManager: ObservableObject {
    var audioPlayer: AVPlayer?
    @Published var song: SongModel? = nil
//    @Published var duration: CMTime? = nil
    @Published var isPlaying: Bool = false
    
    func selectAudio(song: SongModel) {
        self.song = song
        if let url = URL(string: song.url) {
            let item = AVPlayerItem(url: url)
//            self.duration = item.asset.duration
            self.audioPlayer = AVPlayer(playerItem: item)
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


//extension CMTime {
//    
//}
