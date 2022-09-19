//
//  UserTarget.swift
//  RxMoyaDemo
//
//  Created by Ahmed Fathy on 19/09/2022.
//

import Foundation
import Moya


enum UserService {
    case readUsers
    case createUser(User)
}

extension UserService: TargetType{
    
    var baseURL: URL{
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
        
    var path: String {
        return "/users"
    }
    
    var method: Moya.Method {
        switch self {
        case .readUsers:
            return .get
        case .createUser(_):
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .readUsers:
            return .requestPlain
        case .createUser(let user):
            return .requestParameters(parameters: user.dictionary, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
   
    
    
}

extension Encodable {
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
    }
}
