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
    
    var isLoadError: MutableProperty<Bool> = MutableProperty(false)
    
    var repos: MutableProperty<[RepoProtocol]> = MutableProperty([RepoProtocol]())
    
    let service: RepoService = RepoService()
    
    func fetchRepos(textSignal: Signal<String, Never>) {
        
        let action = self.service
            .fetchRepos(state: textSignal)
        
        action.values
            .observe(Signal<[Repository], Never>.Observer{ event in
                if self.isSearched {
                    self.isLoading.value = false
                    
                    if self.lastSearchText != "" {
                        self.repos.value = event.value!
                    }
                }
            })

        action.completed
            .observe { (data) in
            print("complete")
            // neu khong phai da search text cuoi cung thi seach tiep
            if !self.isSearched {
                self.isSearched = true
                self.isLoading.value = true
                
                action.apply("")
                    .start()
            }
        }
        
        action.errors
            .observe { (data) in
                print("truy cap bi gioi han")
                self.isLoading.value = false
                self.isLoadError.value = true
                
                //co gang load lai
//                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3, execute: {
//                    self.isLoading.value = true
//
//                    action.apply("")
//                        .start()
//                })
            }
        
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
