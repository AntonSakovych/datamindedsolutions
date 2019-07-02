//
//  TableViewCell.swift
//  Datamindedsolutions
//
//  Created by Anton Sakovych on 7/2/19.
//  Copyright © 2019 Anton Sakovych. All rights reserved.
//

import UIKit
class TableViewCell : UITableViewCell {
    /// Outlets
    
    var ivAvatar: UIImageView!
    var ivViewStatus: UIImageView!
    var btnRemoveCell: UIButton!
    
    /// Properties
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
        
        if item.isOpen == true {
            ivViewStatus.backgroundColor = UIColor.white
        } else {
             ivViewStatus.backgroundColor = UIColor.blue
        }
        
        if let linkUrl = item.thumbnailLink {
            ApiCall.loadImageFrom(NSURL(string: linkUrl)! as URL) { (url, imege) in
                self.ivAvatar.image = imege
            }
        }
    }
    
    func setupOutlets() {
        
        ivViewStatus = UIImageView()
        ivViewStatus.backgroundColor = UIColor.blue
        ivViewStatus.layer.cornerRadius = 9
        ivViewStatus.clipsToBounds = true
        addSubview(ivViewStatus)
        
        ivAvatar = UIImageView()
        ivAvatar.contentMode = UIView.ContentMode.scaleAspectFit
        addSubview(ivAvatar)
        
        btnRemoveCell = UIButton()
        btnRemoveCell.setTitle(NSLocalizedString("Cell_Button", comment: ""),for: .normal)
        addSubview(btnRemoveCell)
        
    }
    
    func setupConstraints() {
        
        // ivAvatar
        ivAvatar.translatesAutoresizingMaskIntoConstraints = false
        ivAvatar.topAnchor.constraint(equalTo: topAnchor, constant: 35).isActive = true
        ivAvatar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        ivAvatar.heightAnchor.constraint(equalToConstant: 135).isActive = true
        ivAvatar.widthAnchor.constraint(equalToConstant: 135).isActive = true
        
        // ivViewStatus
        ivViewStatus.translatesAutoresizingMaskIntoConstraints = false
        ivViewStatus.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        ivViewStatus.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        ivViewStatus.heightAnchor.constraint(equalToConstant: 18).isActive = true
        ivViewStatus.widthAnchor.constraint(equalToConstant: 18).isActive = true
        
        // btnRemoveCell
        btnRemoveCell.translatesAutoresizingMaskIntoConstraints = false
        btnRemoveCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        btnRemoveCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        btnRemoveCell.heightAnchor.constraint(equalToConstant: 24).isActive = true
        btnRemoveCell.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
    }
    
    
}
