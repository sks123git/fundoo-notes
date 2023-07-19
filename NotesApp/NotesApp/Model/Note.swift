//
//  TableData.swift
//  
//
//  Created by Macbook on 27/06/23.
//

struct Note: Codable{
    var uid: String?
    var title: String?
    var note: String?
    var isDeleted: Bool = false
//    enum CodingKeys: String, CodingKey{
//        case title
//        case note
//    }
}
