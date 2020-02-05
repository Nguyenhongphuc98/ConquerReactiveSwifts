//
//  UserViewModel.swift
//  ConquerReactiveSwift
//
//  Created by CPU11716 on 2/5/20.
//  Copyright © 2020 CPU11716. All rights reserved.
//

import UIKit
import ReactiveSwift

class UserViewModel {

    var isLoading: MutableProperty<Bool> = MutableProperty(false)
    var isLoadchange: MutableProperty<Bool> = MutableProperty(false)
    var users: [User] = [User]()
    
    private var service: UserService = UserService()
    
    func fetchUsers() {
        self.isLoading.value = true
        
        self.service
            .fetchUsers()
            .start(Signal<[User], Error>.Observer { value in
                print("receive \(value)")
                
                if let userss = value.value {
                    self.users = userss
                    self.isLoading.value = false
                    self.isLoadchange.value = true
                }
            })
    }
}
