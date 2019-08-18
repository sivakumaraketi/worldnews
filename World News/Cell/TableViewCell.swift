//
//  TableViewCell.swift
//  World News
//
//  Created by Siva Kumar Aketi on 11/1/17.
//  Copyright © 2017 Siva Kumar Aketi. All rights reserved.
//

import UIKit



class TableViewCell: UITableViewCell {
    
 

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgImage: UIImageView!
    
    @IBOutlet weak var backgroundview: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        backgroundview.layer.cornerRadius=10
        backgroundview.layer.masksToBounds = false
       backgroundview.backgroundColor = bgcolor

       
        // Configure the view for the selected state
    }
    
    
   

}
 
