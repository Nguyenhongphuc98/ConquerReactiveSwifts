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
    var users: MutableProperty<[UserProtocol]> = MutableProperty([UserProtocol]())
    
    private var service: UserService = UserService()
    
    func fetchUsers() {
        self.isLoading.value = true
        
        self.service
            .fetchUsers()
            .start(Signal<[User], Error>.Observer (value: { newValue in
                
                //loai bo nil va setup data cho view model
                self.users.value = newValue.compactMap({ u -> User? in
                    return u
                })
                self.isLoading.value = false
            }, failed: { error in
                print(error.localizedDescription)
                
            }, completed: {print("load complete")}))
    }
}
