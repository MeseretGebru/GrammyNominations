//
//  GrammyTableViewCell.swift
//  GrammyNominations
//
//  Created by Richard Crichlow on 1/30/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class GrammyTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var albumLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
