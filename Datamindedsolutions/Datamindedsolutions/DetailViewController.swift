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
    private var ivAvatar: UIImageView!
    
    /// Properties
    private var redditItem : RedditItem?
    
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
        addGesture()
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
    
    
    /// fuctions
    func addGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        ivAvatar.isUserInteractionEnabled = true
        ivAvatar.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        guard tappedImage.image != nil else {
            print("Image not found!")
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(tappedImage.image!, self, #selector(DetailViewController.image(_:didFinishSavingWithError:contextInfo:)), nil)
        
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        
        if error != nil {
            print("Save error")
        } else {
            print("Saved!")
        }
    }
}
