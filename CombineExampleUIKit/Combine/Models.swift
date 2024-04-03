//
//  Models.swift
//  CombineExampleUIKit
//
//  Created by Oleg Ten on 07/07/2022.
//

import Foundation


struct User: Decodable {
    let id: Int
    let name: String
}

struct Post: Decodable {
    var id: Int
    var userId: Int
}

struct Comment: Decodable {
    var id: Int
    var postId: Int
    var email: String
    var name: String
}

enum ApiError: Error {
    case userError
    case postError
    case commentsError
}
