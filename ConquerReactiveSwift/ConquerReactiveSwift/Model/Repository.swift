//
//  Repository.swift
//  ConquerReactiveSwift
//
//  Created by CPU11716 on 2/10/20.
//  Copyright © 2020 CPU11716. All rights reserved.
//

import UIKit

protocol RepoProtocol {
    
    var name: String { get set }
    
    var des: String { get set }
    
    var language: String { get set }
}

class Repository: NSObject, RepoProtocol {

    var name: String
    
    var des: String
    
    var language: String
    
    public init(name: String, des: String, lang: String) {
        self.name = name
        self.des = des
        self.language = lang
    }
    
    override var description: String {
        return name
    }
}
