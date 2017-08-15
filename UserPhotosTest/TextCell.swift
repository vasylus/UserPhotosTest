//
//  TextCell.swift
//  UserPhotosTest
//
//  Created by Vasiliy Vasilchenko on 8/14/17.
//  Copyright © 2017 vasyl. All rights reserved.
//

import Foundation
import UIKit

class TextCell: UITableViewCell {
    
    var addNewPhotoButton = UIButton()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addNewPhotoButton.frame = CGRect.init(x: 16, y: 0, width: contentView.frame.size.width - 32, height: contentView.frame.size.height)
        addNewPhotoButton.setTitleColor(.black, for: .normal)
        
        addNewPhotoButton.isEnabled = false
        addNewPhotoButton.contentHorizontalAlignment = .left
        contentView.addSubview(addNewPhotoButton)

        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[addNewPhotoButton]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["addNewPhotoButton": addNewPhotoButton]))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[addNewPhotoButton]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["addNewPhotoButton": addNewPhotoButton]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
