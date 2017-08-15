//
//  PhotoCell.swift
//  UserPhotosTest
//
//  Created by Vasiliy Vasilchenko on 8/14/17.
//  Copyright © 2017 vasyl. All rights reserved.
//

import Foundation
import UIKit

class PhotoCell: UITableViewCell {
    
    var photoImageView = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(photoImageView)
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[photoImageView]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["photoImageView": photoImageView]))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-4-[view]-4-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": photoImageView]))
//        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[view(==60)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": photoImageView]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        photoImageView.frame = CGRect(x: 20, y: 0, width: 70, height: 40)
    }
}

