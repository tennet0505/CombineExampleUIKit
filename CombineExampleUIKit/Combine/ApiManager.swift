//
//  ApiManager.swift
//  CombineExampleUIKit
//
//  Created by Oleg Ten on 07/07/2022.
//

import Foundation
import Combine

class ApiManager {
    
    var publisher: AnyPublisher<[User], Error> {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")
        
        return URLSession.shared.dataTaskPublisher(for: url!)
            .map{ $0.data }
            .decode(type: [User].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    // requests for chain of requests
    
    func getUsers() -> AnyPublisher<[User], Error> {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{ $0.data }
            .decode(type: [User].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func getPosts(userId: Int) -> AnyPublisher<[Post], Error> {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts?userId=\(userId)")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{ $0.data }
            .decode(type: [Post].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func getComments(postId: Int) -> AnyPublisher<[Comment], Error> {
        let url = URL(string:  "https://jsonplaceholder.typicode.com/comments?postId=\(postId)")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{ $0.data }
            .decode(type: [Comment].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}


