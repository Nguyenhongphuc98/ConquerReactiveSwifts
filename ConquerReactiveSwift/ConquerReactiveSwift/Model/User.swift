//
//  User.swift
//  ConquerReactiveSwift
//
//  Created by CPU11716 on 2/5/20.
//  Copyright © 2020 CPU11716. All rights reserved.
//

import UIKit

class User: NSObject {

    var id: String
    
    var name: String
    
    var username: String
    
    var email: String
    
    var phone: String
    
    var website: String
    
    public init(id: String, name: String, username: String, email: String, phone: String, website: String) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.phone = phone
        self.website = website
    }
    
    override var description: String {
        return "user: \(name)"
    }
}
