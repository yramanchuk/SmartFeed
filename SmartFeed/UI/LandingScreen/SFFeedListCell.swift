//
//  SFFeedListCell.swift
//  SmartFeed
//
//  Created by Yury Ramanchuk on 4/4/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

import UIKit

class SFFeedListCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnCount: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
