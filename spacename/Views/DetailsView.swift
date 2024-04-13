//
//  DetailsView.swift
//  spacename
//
//  Created by Noor Ahmed on 05/04/24.
//

import SwiftUI
import Kingfisher
import SwiftUIPager

struct DetailsView: View {
    var songList: [SongModel]
    @Binding var selectedIndex: Int?
    @EnvironmentObject var audioManager: AudioManager
    
    var song: SongModel {
        
        if let index = selectedIndex, index < songList.count {
            return songList[index]
        } else {
            return songList[0]
        }
    }
    
    let scrollViewHeight: CGFloat = 300
    var isPlaying: Bool = true
    
    var body: some View {
        VStack(spacing: 56) {
            imageScrollView
            
            VStack(spacing: 0) {
                Text(song.name ?? "unknown")
                    .font(.system(size: 26))
                    .fontWeight(.bold)
                
                Text(song.artist ?? "unknown")
                    .font(.system(size: 21))
                    .opacity(0.6)
            }
            
            VStack {
                Slider(value: .constant(1.0))
                    .progressViewStyle(.linear)
                    .tint(.white)
                    .accentColor(.white)
                
                HStack {
                    Text("0:00")
                        .opacity(0.5)
                    Spacer()
                    Text("0:00")
                        .opacity(0.5)
                }
            }
            .padding(.horizontal, 20)
            
            controls
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .foregroundStyle(.white)
    }
    
    var imageScrollView: some View {
        GeometryReader { geo in
            let index = songList.firstIndex(of: song)
            let size = geo.size.width - 60
            Pager(page: .withIndex(index ?? 0), data: songList) { song in
                KFImage(song.getImageURL)
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .cornerRadius(4)
            }
            .preferredItemSize(CGSize(width: size, height: size))
            .loopPages()
            .itemSpacing(12)
            .interactive(scale: 0.95)
            .onPageChanged { index in
                self.selectedIndex = index
                audioManager.selectAudio(song: song)
            }
        }
        .frame(height: scrollViewHeight)
    }
    
    var controls: some View {
        HStack {
            Spacer()
            Image(systemName: "forward.fill")
                .resizable()
                .rotationEffect(.degrees(180))
                .scaledToFit()
                .frame(width: 44, height: 44)
                .opacity(0.5)
                .onTapGesture {
                    if let index = selectedIndex, index > 0 {
                        self.selectedIndex! -= 1
                    } else {
                        self.selectedIndex = songList.count - 1
                    }
                    audioManager.selectAudio(song: song)
                }
            
            Spacer()
            if audioManager.isPlaying {
                Image(systemName: "pause.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 64, height: 64)
                    .onTapGesture {
                        audioManager.pauseAudio()
                    }
            } else {
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 64, height: 64)
                    .onTapGesture {
                        audioManager.playAudio()
                    }
            }
            Spacer()
            Image(systemName: "forward.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
                .opacity(0.5)
                .onTapGesture {
                    if let index = selectedIndex, index < songList.count {
                        self.selectedIndex! += 1
                    } else {
                        self.selectedIndex = 0
                    }
                    
                    audioManager.selectAudio(song: song)
                }
            Spacer()
        }
    }
}

#Preview {
    DetailsView(songList: [], selectedIndex: .constant(0), audioManager: .init())
}



//ScrollViewReader { reader in
//    ScrollView(.horizontal) {
//        LazyHStack(spacing: 16) {
//            ForEach(0..<Int.max, id: \.self) { index in
//                let index = abs(index % songList.count)
//                let selected = index == selectedIndex
//                let song = songList[index]
//                let imageURL = songList[index].getImageURL
//                let size = geo.size.width - 44
//                KFImage(imageURL)
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: size, height: size)
//                    .id(song.id)
//                    .clipped()
//            }
//            .task {
//                reader.scrollTo(song.id)
//            }
//        }
//        .scrollTargetLayout()
//    }
//    .frame(maxHeight: .infinity)
//    .disabled(true)
//    .onChange(of: song) { song in
//        reader.scrollTo(song.id)
//    }
//}
