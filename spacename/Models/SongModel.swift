//
//  SongModel.swift
//  spacename
//
//  Created by Noor Ahmed on 04/04/24.
//

import Foundation


struct SongModel: Codable, Identifiable {
    var id: Int?
    var status: Status?
    var sort: Int?
    var userCreated, dateCreated, userUpdated, dateUpdated: String?
    var name, artist, accent, cover: String?
    var topTrack: Bool?
    var url: String?

    enum CodingKeys: String, CodingKey {
        case id, status, sort
        case userCreated = "user_created"
        case dateCreated = "date_created"
        case userUpdated = "user_updated"
        case dateUpdated = "date_updated"
        case name, artist, accent, cover
        case topTrack = "top_track"
        case url
    }
    
    enum Status: String, Codable {
        case published = "published"
    }
}

extension SongModel {
    
    var getImageURL: URL? {
        URL(string: "https://cs.saespace.co/assets/\(cover ?? "")")
    }
    
}
