//
//  UserVC.swift
//  ConquerReactiveSwift
//
//  Created by CPU11716 on 2/5/20.
//  Copyright © 2020 CPU11716. All rights reserved.
//

import UIKit
import ReactiveSwift

class UserVC: UIViewController {

    @IBOutlet weak var userTableView: UserTableView!
    
    var viewModel: UserViewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindEvent()
    }
    
    func bindEvent() {
        print("binding event...")
        viewModel.isLoading
            .signal
            .take(during: reactive.lifetime)
            .observeValues { (loading) in
                if loading {
                    print("loading...")
                } else {
                    print("no loading")
                }
        }
        
        viewModel.users
            .signal
            .take(during: reactive.lifetime)
            .observe(on: UIScheduler())
            .observe { (users) in
                if let us = users.value {
                    self.userTableView.reloadData(u: us)
                }
        }
        
        self.viewModel.fetchUsers()
    }

}
