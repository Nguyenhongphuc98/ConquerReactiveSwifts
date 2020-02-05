//
//  UserVC.swift
//  ConquerReactiveSwift
//
//  Created by CPU11716 on 2/5/20.
//  Copyright © 2020 CPU11716. All rights reserved.
//

import UIKit

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
        
        viewModel.isLoadchange
            .signal
            .take(during: reactive.lifetime)
            .observeValues { (change) in
                if change {
                    print("change")
                    self.userTableView.users = self.viewModel.users
                    self.userTableView.reloadData()
                } else {
                    print("no loading")
                }
        }
        
        self.viewModel.fetchUsers()
    }

}
