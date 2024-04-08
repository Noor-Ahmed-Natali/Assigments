//
//  BaseModel.swift
//  spacename
//
//  Created by Noor Ahmed on 04/04/24.
//

import Foundation

struct BaseModel<T: Codable>: Codable {
    var data: T?
}
