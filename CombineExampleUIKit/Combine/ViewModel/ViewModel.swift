//
//  ViewModel.swift
//  CombineExampleUIKit
//
//  Created by Oleg Ten on 07/07/2022.
//

import Foundation
import Combine

class ViewModel {
        
    var apiManager = ApiManager()
    var subscribers = Set<AnyCancellable>()
    
    init() {}
    
    func fetchComments(complition: @escaping ([Comment]) -> ()) {
        apiManager.getUsers()
            .flatMap { [weak self] users -> AnyPublisher<[Post], Error> in
                guard let user = users.last else {
                    return Fail(error: ApiError.userError).eraseToAnyPublisher()
                }
                return (self?.apiManager.getPosts(userId: user.id))!
            }.flatMap {[weak self]  posts -> AnyPublisher<[Comment], Error> in
                guard let post = posts.last else {
                    return Fail(error: ApiError.postError).eraseToAnyPublisher()
                }
                return (self?.apiManager.getComments(postId: post.id))!
            }.sink { _ in
                print("Complited")
            } receiveValue: { comments in
                print(comments)
                complition(comments)
            }.store(in: &subscribers)
        
    }
}
