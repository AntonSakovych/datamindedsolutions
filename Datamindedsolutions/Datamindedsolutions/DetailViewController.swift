//
//  DetailViewController.swift
//  Datamindedsolutions
//
//  Created by Anton Sakovych on 7/2/19.
//  Copyright © 2019 Anton Sakovych. All rights reserved.
//

import Foundation
import UIKit
class DetailViewController: UIViewController {
    
    
    /// Outlets
    var ivAvatar: UIImageView!
    
    /// Properties
    var redditItem : RedditItem?
    
    
    
    required init(item: RedditItem?) {
        redditItem = item
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupOutlets()
        setupConstraints()
        configureteSelf()
    }
    
    
    
    func configureteSelf() {
        
        if let linkUrl = redditItem?.thumbnailLink {
            ApiCall.loadImageFrom(NSURL(string: linkUrl)! as URL) { (url, imege) in
                self.ivAvatar.image = imege
            }
        }
    }
    
    func setupOutlets() {
        ivAvatar = UIImageView()
        ivAvatar.contentMode = UIView.ContentMode.scaleAspectFit
        view.addSubview(ivAvatar)
    }
    
    func setupConstraints() {
        
        ivAvatar.translatesAutoresizingMaskIntoConstraints = false
        ivAvatar.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        ivAvatar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        ivAvatar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        ivAvatar.heightAnchor.constraint(equalToConstant: 200).isActive = true

    }
    
}
