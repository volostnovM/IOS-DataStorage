//
//  Post.swift
//  Navigation
//

import Foundation

struct PostVK {
    let author: String
    let description: String
    let image: String
    let likes: Int16
    let views: Int16
}

struct Storage {
    
   static let arrayPost = [
    PostVK(
            author: "Ivan",
            description: "Интересный пост от Ивана",
            image: "public_1",
            likes: Int16.random(in: 0...500),
            views: Int16.random(in: 500...1000)
        ),
    PostVK(
            author: "Masha",
            description: "Интересный пост от Маши",
            image: "public_2",
            likes: Int16.random(in: 0...500),
            views: Int16.random(in: 500...1000)
        ),
    PostVK(
            author: "Dasha",
            description: "Интересный пост от Даши",
            image: "public_3",
            likes: Int16.random(in: 0...500),
            views: Int16.random(in: 500...1000)
        ),
    PostVK(
            author: "Petr",
            description: "Интересный пост от Петра",
            image: "public_4",
            likes: Int16.random(in: 0...500),
            views: Int16.random(in: 500...1000)
        ),
    ]
}
