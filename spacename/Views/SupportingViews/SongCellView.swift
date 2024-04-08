//
//  SongCellView.swift
//  spacename
//
//  Created by Noor Ahmed on 08/04/24.
//

import SwiftUI
import Kingfisher

struct SongCellView: View {
    var song: SongModel
    var body: some View {
        HStack(spacing: 16) {
            KFImage(song.getImageURL)
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
            
            VStack(alignment: .leading, spacing: 0) {
                Text(song.name ?? "Unknown")
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                
                Text(song.artist ?? "Unknown")
                    .foregroundStyle(.white.opacity(0.6))
            }
            
            
        }
    }
}

#Preview {
    SongCellView(song: .init())
}
