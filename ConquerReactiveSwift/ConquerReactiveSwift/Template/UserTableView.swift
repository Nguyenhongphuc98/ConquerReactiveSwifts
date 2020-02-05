//
//  UserTableView.swift
//  ConquerReactiveSwift
//
//  Created by CPU11716 on 2/5/20.
//  Copyright © 2020 CPU11716. All rights reserved.
//

import UIKit

class UserTableView: UIView {
    
    var tableView: UITableView!
    var users: [User] = [User]()

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpview()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpview()
    }
    
    func setUpview() {
        let tableView: UITableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let views: [String: Any] = ["tableview": tableView]
        
        self.addSubview(tableView)
        self.tableView = tableView
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableview]|",
                                                               metrics: nil,
                                                               views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableview]|",
        metrics: nil,
        views: views))
        
        let nib: UINib = UINib.init(nibName: "UserTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "UserTableViewCell")
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}

//UITableView Delegate====================================
extension UserTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//UITableView Datasource====================================
extension UserTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        let cell: UserTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        cell.setUpView(user: user)
        
        return cell
    }
}
