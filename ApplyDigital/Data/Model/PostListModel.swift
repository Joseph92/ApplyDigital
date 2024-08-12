//
//  PostListModel.swift
//  ApplyDigital
//
//  Created by Josseph Colonia on 10/08/24.
//

import Foundation

struct PostModel: Hashable, Codable {
    var id: String
    var author: String?
    var title: String?
    var body: String?
    var createdAt: Int?

    enum CodingKeys: String, CodingKey {
        case id = "objectID"
        case author
        case title = "story_title"
        case body = "comment_text"
        case createdAt = "created_at_i"
    }
}

struct PostListModel: Codable {
    var postList: [PostModel]

    enum CodingKeys: String, CodingKey {
        case postList = "hits"
    }
}
