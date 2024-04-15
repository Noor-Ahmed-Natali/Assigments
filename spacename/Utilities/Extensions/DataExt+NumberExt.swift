//
//  DataExt.swift
//  spacename
//
//  Created by Noor Ahmed on 04/04/24.
//

import Foundation

extension Data {
    var prettyPrintedJSONString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: [.json5Allowed, .topLevelDictionaryAssumed]),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) else { return nil }
        return prettyPrintedString
    }
}

extension CGFloat {
    
    var toTime: String {
        let min: Int = Int(self)/60
        let sec: Int = Int(self)%60
        
        return String(format: "%02d:%02d", min, sec)
    }
    
}
