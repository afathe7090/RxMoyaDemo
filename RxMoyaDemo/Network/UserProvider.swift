//
//  UserProvider.swift
//  RxMoyaDemo
//
//  Created by Ahmed Fathy on 19/09/2022.
//

import Foundation
import RxSwift
import Moya
import RxMoya


protocol UserNetwork: AnyObject {
    func readAllUsers() -> Single<[User]>
    func createUser(_ user: User) -> Single<User>
}


class UserNetworkImplementaion: UserNetwork {
    
    private let provider = MoyaProvider<UserService>()
    
    func readAllUsers() -> Single<[User]> {
        return provider
            .rx
            .request(.readUsers)
            .filterSuccessfulStatusCodes()
            .map([User].self)
        
    }
    
    
    func createUser(_ user: User) -> Single<User>{
        return provider
            .rx
            .request(.createUser(user))
            .filterSuccessfulStatusCodes()
            .map(User.self)
    }
    
}



