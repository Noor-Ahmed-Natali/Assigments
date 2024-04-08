//
//  ForYouViewModel.swift
//  spacename
//
//  Created by Noor Ahmed on 04/04/24.
//

import Foundation

class ForYouViewModel: ObservableObject {
    
    @Published var songList: [SongModel] = []
    @Published var selectedIndex: Int? = nil
    @Published var isLoading: Bool = false
    @Published var showSheet: Bool = false
    
    func fetchSong() async {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        let route = "https://cms.samespace.com/items/songs"
        let result = await APIManager.shared.baseRequest(route: route, method: .get, type: [SongModel].self)
        switch result {
        case .success(let songs):
            DispatchQueue.main.async {
                self.songList = songs ?? []
            }
        case .failure(let failure):
            print("Show Alert")
        }
        DispatchQueue.main.async {
            self.isLoading = false
        }
    }
    
}
