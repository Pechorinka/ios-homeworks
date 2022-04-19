//
//  News.swift
//  Navigation
//
//  Created by Tatyana Sidoryuk on 12.04.2022.
//

struct News: Decodable {

    struct Post: Decodable {
        let author, description, image: String
        let likes: Int
        let views: Int

        enum CodingKeys: String, CodingKey {
                case author, description, image, likes, views
            }
    }
    let posts: [Post]
}

