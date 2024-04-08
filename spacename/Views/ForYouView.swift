//
//  ForYouView.swift
//  spacename
//
//  Created by Noor Ahmed on 04/04/24.
//

import SwiftUI
import Kingfisher

struct ForYouView: View {
    @EnvironmentObject var audioManager: AudioManager
    @StateObject var viewModel: ForYouViewModel = .init()
    
    var body: some View {
        ZStack(alignment: .top) {
            if viewModel.isLoading {
                ProgressView()
            } else {
                listView
                    .sheet(isPresented: $viewModel.showSheet) {
                        DetailsView(songList: viewModel.songList,
                                    selectedIndex: $viewModel.selectedIndex)
                        .environmentObject(audioManager)
                            .presentationDragIndicator(.visible)
                    }
            }
        }
        .task {
            if viewModel.songList.isEmpty {
                await viewModel.fetchSong()
            }
        }
    }
    
    var listView: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(0..<viewModel.songList.count, id: \.self) { index in
                    let song = viewModel.songList[index]
                    SongCellView(song: song)
                        .onTapGesture {
                            viewModel.selectedIndex = index
                            viewModel.showSheet = true
                            audioManager.selectAudio(song: song)

                        }
                }
            }
            .padding(20)
        }
    }
    
}

#Preview {
    ForYouView()
}
