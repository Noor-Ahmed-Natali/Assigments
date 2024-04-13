//
//  SongModel.swift
//  spacename
//
//  Created by Noor Ahmed on 04/04/24.
//

import Foundation


struct SongModel: Codable, Identifiable, Equatable {
    var id: Int?
    var status: Status?
    var sort: Int?
    var userCreated, dateCreated, userUpdated, dateUpdated: String?
    var name, artist, accent, cover: String?
    var topTrack: Bool?
    var url: String

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
    
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

extension SongModel {
    
    var getImageURL: URL? {
        let baseURL: String = "https://cms.samespace.com/assets/"
       return URL(string: baseURL + (cover ?? ""))
    }
}
