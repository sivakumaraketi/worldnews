//
//  PaperDetailTableViewCell.swift
//  World News
//
//  Created by Siva Kumar Aketi on 11/16/17.
//  Copyright © 2017 Siva Kumar Aketi. All rights reserved.
//

import UIKit

class PaperDetailTableViewCell: UITableViewCell {
    

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var urlimage: UIImageView!
    
    @IBOutlet weak var backgroundview: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        backgroundview.layer.cornerRadius=0
        backgroundview.layer.masksToBounds = false
        backgroundview.backgroundColor = paperbgcolor
        
        
    }

}
