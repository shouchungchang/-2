//
//  RankTableViewCell.swift
//  Snake
//
//  Created by User04 on 2019/1/3.
//  Copyright © 2019 User04. All rights reserved.
//

import Foundation
import UIKit

class RankTableViewCell: UITableViewCell {
    
    @IBOutlet weak var NOLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
