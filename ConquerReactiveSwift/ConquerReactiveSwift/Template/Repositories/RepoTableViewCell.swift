//
//  RepoTableViewCell.swift
//  ConquerReactiveSwift
//
//  Created by CPU11716 on 2/10/20.
//  Copyright © 2020 CPU11716. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setUpView(repo: RepoProtocol) {
        nameLabel.text = repo.name
        desLabel.text = "@" + repo.des
        languageLabel.text = repo.language
    }
}
