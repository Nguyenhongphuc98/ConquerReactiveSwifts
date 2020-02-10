//
//  RepoViewModel.swift
//  ConquerReactiveSwift
//
//  Created by CPU11716 on 2/10/20.
//  Copyright © 2020 CPU11716. All rights reserved.
//

import UIKit
import ReactiveSwift

class RepoViewModel {

    var isLoading: MutableProperty<Bool> = MutableProperty(false)
    
    var repos: MutableProperty<[RepoProtocol]> = MutableProperty([RepoProtocol]())
    
    let service: RepoService = RepoService()
    
    func fetchRepos(textSignal: Signal<String, Never>) {
        
        let action = self.service
            .fetchRepos(state: textSignal)
        
        action.values
            .observe(on: UIScheduler())
            .observe(Signal<[Repository], Never>.Observer({rs in
            self.repos.value = rs.value!
            self.isLoading.value = false
        }))
        
        textSignal.observe(Signal<String, Never>.Observer({val in
            self.isLoading.value = true
                
            action.apply("")
            .start()
        }))
        
    }
}
