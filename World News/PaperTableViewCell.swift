//
//  PaperTableViewCell.swift
//  World News
//
//  Created by Siva Kumar Aketi on 11/12/17.
//  Copyright © 2017 Siva Kumar Aketi. All rights reserved.
//

import UIKit

class PaperTableViewCell: UITableViewCell {
    
    @IBOutlet weak var url: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var title: UILabel!
    
    
    @IBOutlet weak var backgroundview: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        backgroundview.layer.cornerRadius=10
        backgroundview.layer.masksToBounds = false
        backgroundview.backgroundColor = paperbgcolor
    }

}
