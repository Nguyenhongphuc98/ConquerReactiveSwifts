//
//  RepoTableView.swift
//  ConquerReactiveSwift
//
//  Created by CPU11716 on 2/10/20.
//  Copyright © 2020 CPU11716. All rights reserved.
//

import UIKit

class RepoTableView: UIView {

    var tableView: UITableView!
    var repos: [RepoProtocol] = [RepoProtocol]()
    
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
            //tableView.estimatedRowHeight = 65
            
            let views: [String: Any] = ["tableview": tableView]
            
            self.addSubview(tableView)
            self.tableView = tableView
            
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableview]|",
                                                                   metrics: nil,
                                                                   views: views))
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableview]|",
            metrics: nil,
            views: views))
            
            let nib: UINib = UINib.init(nibName: "RepoTableViewCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "RepoTableviewCell")
        }
        
        func reloadData(r: [RepoProtocol]) {
            self.repos = r
            tableView.reloadData()
        }
    }

    //UITableView Delegate====================================
    extension RepoTableView: UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    //UITableView Datasource====================================
    extension RepoTableView: UITableViewDataSource {
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return repos.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let repo = repos[indexPath.row]
            let cell: RepoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RepoTableviewCell", for: indexPath) as! RepoTableViewCell
            cell.setUpView(repo: repo)
            
            return cell
        }

}
