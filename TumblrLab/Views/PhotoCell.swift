//
//  PhotoCell.swift
//  TumblrLab
//
//  Created by Derek Chang on 1/25/20.
//  Copyright © 2019 Derek Chang. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {


    @IBOutlet weak var photoView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
