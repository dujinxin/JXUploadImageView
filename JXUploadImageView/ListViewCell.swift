//
//  ListViewCell.swift
//  JXUploadImageView
//
//  Created by 杜进新 on 2017/8/1.
//  Copyright © 2017年 dujinxin. All rights reserved.
//

import UIKit
import SDWebImage

class ListViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var uploadImageView: JXUploadImageView!
    @IBOutlet weak var uploadImageViewHeightConstraint: NSLayoutConstraint!
    
    var model: ListModel? {
        didSet{
            titleLabel.text = model?.title
            contentLabel.text = model?.content
            
            uploadImageView.handleImageString(imageString: model?.image)
         
            if let image = model?.image,
                image.hasPrefix("http") == true{
                uploadImageViewHeightConstraint.constant = 128
            }else{
                uploadImageViewHeightConstraint.constant = 0
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
