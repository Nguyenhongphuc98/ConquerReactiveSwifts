//
//  RepoViewModel.swift
//  ConquerReactiveSwift
//
//  Created by CPU11716 on 2/10/20.
//  Copyright © 2020 CPU11716. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

class RepoViewModel {
    
    var isSearched: Bool = false
    var lastSearchText: String? = ""

    var isLoading: MutableProperty<Bool> = MutableProperty(false)
    
    var repos: MutableProperty<[RepoProtocol]> = MutableProperty([RepoProtocol]())
    
    let service: RepoService = RepoService()
    
    func fetchRepos(textSignal: Signal<String, Never>) {
        
        let action = self.service
            .fetchRepos(state: textSignal)
        
        action.values
            .observe(on: UIScheduler())
            .observe(Signal<[Repository], Never>.Observer{ event in
                print("here")
                switch event {
                case let .value(repo):
                    
                    if !self.isSearched {
                        self.isSearched = true
                        self.isLoading.value = true
                        print("next")
                        if action.isExecuting.value {
                            print("still excute")
                        }
                        action.apply("")
                            .start()
                    } else {
                        self.isLoading.value = false
                        
                        if self.lastSearchText != "" {
                            self.repos.value = repo
                        }
                    }
                    
                case .completed:
                    self.isLoading.value = false
                    print("complete")
                case let .failed(error):
                    print(error)
                case  .interrupted:
                    print("interup")
                    break
                }})

        
        textSignal.observe(Signal<String, Never>.Observer({val in
            self.lastSearchText = val.value!
            
            if val.value == "" {
                self.repos.value.removeAll()
                self.isSearched = true
                self.isLoading.value = false
            } else {
            
                if action.isExecuting.value {
                    self.isSearched = false
                } else {
                    self.isSearched = true
                    self.isLoading.value = true
                    
                    action.apply("")
                    .start()
                }
            }
        }))
        
    }
}
