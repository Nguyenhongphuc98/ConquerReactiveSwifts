//
//  UserService.swift
//  ConquerReactiveSwift
//
//  Created by CPU11716 on 2/5/20.
//  Copyright © 2020 CPU11716. All rights reserved.
//

import Foundation
import ReactiveSwift

class UserService {
    
    private var URL: String = "https://jsonplaceholder.typicode.com/users"
    
    //signalproducer co trach nhiem phat ra tin hieu (luong users) khi load complete
    func fetchUsers() -> SignalProducer<[User], Error> {
        return SignalProducer { observer, disposable in
            //tao data gia thay vi load theo url
            var users: [User] = [User]()
            for _ in 0..<10 {
                let user = User.init(id: "1", name: "hong phuc", username: "phuc1998", email: "hello@gmail.com", phone: "012345678", website: "www.abc.com")
                users.append(user)
            }
            
            //thong bao da load xong danh sach users
            observer.send(value: users)
        }
    }
}
