//
//  Post.swift
//  Navigation
//

import Foundation

struct PostVK {
    let author: String
    let description: String
    let image: String
    let likes: Int
    let views: Int
}

struct Storage {
    
   static let arrayPost = [
    PostVK(
            author: "Ivan",
            description: "Интересный пост от Ивана",
            image: "public_1",
            likes: 5,
            views: 255
        ),
    PostVK(
            author: "Masha",
            description: "Интересный пост от Маши",
            image: "public_2",
            likes: 15,
            views: 5000
        ),
    PostVK(
            author: "Dasha",
            description: "Интересный пост от Даши",
            image: "public_3",
            likes: 52,
            views: 300
        ),
    PostVK(
            author: "Petr",
            description: "Интересный пост от Петра",
            image: "public_4",
            likes: 57,
            views: 100
        ),
    ]
}
