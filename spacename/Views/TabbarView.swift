//
//  TabbarView.swift
//  spacename
//
//  Created by Noor Ahmed on 04/04/24.
//

import SwiftUI

struct TabbarView: View 
{
    enum Tabs: String, CaseIterable {
        case forYou = "For You"
        case topTracks = "Top Tracks"
    }
    
    @State private var selectedTab: Tabs = .forYou
    @StateObject var audioManager: AudioManager = .init()
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selectedTab) {
                ForYouView()
                    .tag(Tabs.forYou)
                    .environmentObject(audioManager)
                
                TopTracksView()
                    .tag(Tabs.topTracks)
                    .environmentObject(audioManager)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            
            if audioManager.song != nil {
            PlayerIndicatorView(audioManager: audioManager)
            }
            
            HStack(alignment: .top) {
                ForEach(Tabs.allCases, id: \.rawValue) { tab in
                    let isSelected = selectedTab == tab
                    
                    Spacer()
                    
                    VStack(spacing: 8) {
                        Text(tab.rawValue)
                            .frame(height: 24)
                            .foregroundStyle(.white.opacity(isSelected ? 1 : 0.5))
                        if isSelected {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 6, height: 6)
                        }
                    }
                    .onTapGesture {
                        self.selectedTab = tab
                    }
                    
                    Spacer()
                }
            }
            .background {
                LinearGradient(stops: [.init(color: .clear, location: 0.0), .init(color: .black, location: 0.35)], startPoint: .top, endPoint: .bottom)
                .frame(height: 120)
            }
            .padding(.bottom, 18)
            .background(Color.black)
        }
    }
}

#Preview {
    TabbarView()
}
