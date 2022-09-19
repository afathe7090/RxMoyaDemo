//
//  ViewController.swift
//  RxMoyaDemo
//
//  Created by Ahmed Fathy on 19/09/2022.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    private let network: UserNetwork = UserNetworkImplementaion()
    
    let bag = DisposeBag()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readUsersFromApi()
        
        let mockedUser = User(id: Int(66), name: "Ahmed", username: "", email: "",
                              address: .init(street: "", suite: "", city: "", zipcode: "", geo: .init(lat: "", lng: "")),
                              phone: "", website: "", company: .init(name: "", catchPhrase: "", bs: ""))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3 ) {
            self.createUserToApi(mockedUser)
        }
        
    }
    
    fileprivate func readUsersFromApi() {
        network.readAllUsers()
            .asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { users in
                print(users)
            }).disposed(by: bag)
    }
    
    fileprivate func createUserToApi(_ user: User) {
        network.createUser(user)
            .asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(on: MainScheduler.instance)
            .subscribe { user in
                print(user)
            } onError: { error in
                print(error.localizedDescription)
            }
            .disposed(by: bag)
    }
    
    
}

