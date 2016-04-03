//
//  SFFeedDetailListCell.swift
//  SmartFeed
//
//  Created by Yury Ramanchuk on 4/3/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

import UIKit
import FontAwesome_swift

class SFFeedDetailListCell: UITableViewCell {

    @IBOutlet weak var btnNew: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.btnNew.titleLabel?.font = UIFont.fontAwesomeOfSize(15)
        self.btnNew.setTitle(String.fontAwesomeIconWithName(.Asterisk), forState: .Normal)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onNewSelected(sender: AnyObject) {
        debugPrint("onNewSelected")
    }
}
