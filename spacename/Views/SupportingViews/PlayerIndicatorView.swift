//
//  PlayerIndicatorView.swift
//  spacename
//
//  Created by Noor Ahmed on 08/04/24.
//

import SwiftUI
import Kingfisher

struct PlayerIndicatorView: View {
    @ObservedObject var audioManager: AudioManager
    
    var imageURL: URL? {
        audioManager.song?.getImageURL
    }
    var name: String {
        audioManager.song?.name ?? "Unknown"
    }
    
    var body: some View {
        HStack(spacing: 16) {
            image
            
            Text(name)
            
            Spacer()
            
            if audioManager.isPlaying {
                Image(systemName: "pause.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 44, height: 44)
                    .onTapGesture {
                        audioManager.pauseAudio()
                    }
            } else {
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 44, height: 44)
                    .onTapGesture {
                        audioManager.playAudio()
                    }
            }
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 8)
        .background(Color(hex: "#150F07"))
        .foregroundStyle(.white)
    }
    
    var image: some View {
        KFImage(imageURL)
            .resizable()
            .placeholder({
                ZStack {
                    Color.gray
                    Text("No Image")
                        .font(.system(size: 10))
                        .minimumScaleFactor(0.2)
                }
                
            })
            .aspectRatio(contentMode: .fill)
            .frame(width: 48, height: 48)
            .clipShape(Circle())
            .padding(.vertical, 12)
    }
}

#Preview {
    PlayerIndicatorView(audioManager: .init())
}
