//
//  HomeCell.swift
//  CodePath-Instagram
//
//  Created by Akhila Murella on 3/6/16.
//  Copyright © 2016 amurella. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomeCell: UITableViewCell {

    @IBOutlet weak var picView: PFImageView!
    
    @IBOutlet weak var caption: UITextField!
    var picture: PFObject! {
        didSet{
            self.caption.text = picture["caption"] as! String?
        
        self.picView.file = picture["picture"] as? PFFile
        self.picView.loadInBackground()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
