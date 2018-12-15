//
//  PhotoDetailCell.swift
//  TumblrFeed
//
//  Created by Brian Casipit on 12/15/18.
//  Copyright © 2018 Brian Casipit. All rights reserved.
//

import UIKit

class PhotoDetailCell: UITableViewCell {

    @IBOutlet weak var photoDetailImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionTextView: UITextView!
    
    override func awakeFromNib() {
        // NOTE: some properties to remember...
        //outletName.layer.cornerRadius = doubleValue
        //outletName.layer.masksToBounds = true
        //outletName.layer.borderWidth = doubleValue
        
        dateLabel.layer.cornerRadius = 4.0
        dateLabel.layer.masksToBounds = true
        
        captionTextView.layer.cornerRadius = 4.0
    }
    
    

}
