//
//  UserTableViewCell.swift
//  ConquerReactiveSwift
//
//  Created by CPU11716 on 2/5/20.
//  Copyright © 2020 CPU11716. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setUpView(user: UserProtocol) {
        displayNameLabel.text = user.name
        accountLabel.text = "@" + user.username
    }
}
