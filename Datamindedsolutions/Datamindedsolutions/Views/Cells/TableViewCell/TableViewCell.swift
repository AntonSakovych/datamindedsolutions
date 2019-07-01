//
//  TableViewCell.swift
//  Datamindedsolutions
//
//  Created by Anton Sakovych on 7/2/19.
//  Copyright © 2019 Anton Sakovych. All rights reserved.
//

import UIKit
class TableViewCell : UITableViewCell {
    
    var ivAvatar: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupOutlets()
        contentView.backgroundColor = UIColor.black
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureteCell(item: RedditItem) {
        
        if let linkUrl = item.thumbnailLink {
            
            ApiCall.loadImageFrom(NSURL(string: linkUrl)! as URL) { (url, imege) in
                self.ivAvatar.image = imege
            }
        }
    }
    
    func setupOutlets() {
        
        ivAvatar = UIImageView()
        ivAvatar.contentMode = UIView.ContentMode.scaleAspectFit
        addSubview(ivAvatar)
    }
    
    func setupConstraints() {
        
        ivAvatar.translatesAutoresizingMaskIntoConstraints = false
        ivAvatar.topAnchor.constraint(equalTo: topAnchor, constant: 35).isActive = true
        ivAvatar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        ivAvatar.heightAnchor.constraint(equalToConstant: 135).isActive = true
        ivAvatar.widthAnchor.constraint(equalToConstant: 135).isActive = true
    }
}
