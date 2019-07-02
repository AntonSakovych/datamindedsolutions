//
//  ViewController.swift
//  Datamindedsolutions
//
//  Created by Anton Sakovych on 7/1/19.
//  Copyright © 2019 Anton Sakovych. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /// Outlets
    private var tableView: UITableView!
    private var activityIndicator: UIActivityIndicatorView!
    private var refreshControl = UIRefreshControl()
    private var btnRemoveAll: UIButton!
    /// Properties
    
    private let tableviewCellHeight: CGFloat = 305.0
    private let reuseIdentifier = "TableViewCell"
    private var redditItems = [RedditItem]()
    private static let encodingKeyRedditItems = "encodingKeyRedditItems"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("ViewController_Screen_Title", comment: "")
        setupTableView()
        setupRefreshControl()
        setupActivityIndicator()
        getRedditItems()
        setupRemoveAll()
    }
    
    func setupRemoveAll() {
        btnRemoveAll = UIButton()
        btnRemoveAll.setTitle(NSLocalizedString("ViewController_Screen_Button", comment: ""),for: .normal)
        btnRemoveAll.addTarget(self, action: #selector(removeAllAction), for: .touchUpInside)
        view.addSubview(btnRemoveAll)
        btnRemoveAll.translatesAutoresizingMaskIntoConstraints = false
        btnRemoveAll.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        btnRemoveAll.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 5).isActive = true
        btnRemoveAll.heightAnchor.constraint(equalToConstant: 44).isActive = true
        btnRemoveAll.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
    }
    
    @objc func removeAllAction() {
        redditItems.removeAll()
        tableView.reloadData()
    }
    
    func getRedditItems()  {
        activityIndicator.startAnimating()
        ApiCall.getItemsCall { items in
            if let items = items?.responseItems {
                self.redditItems = items
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
    }
    
    func setupRefreshControl() {
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(loadMoreAction), for: .valueChanged)
    }
    
    @objc func loadMoreAction() {
        if let lastAutorId = redditItems.last?.itemId {
            activityIndicator.startAnimating()
            ApiCall.getItemsCall(lastAutorId ,onSuccess: { items in
                if let items = items?.responseItems {
                    self.redditItems = self.redditItems + items
                    DispatchQueue.main.async{
                        self.tableView.reloadData()
                        self.activityIndicator.stopAnimating()
                        self.refreshControl.endRefreshing()
                    }
                }
            })
        }
    }
    
    func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        self.tableView.rowHeight = tableviewCellHeight
        
        tableView.backgroundColor = UIColor.black
        if let tableView = tableView {
            view.addSubview(tableView)
        }
        tableView?.register(TableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    /// RestorableStat
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        guard redditItems.count > 0  else {
            return
        }
        
        coder.encode(redditItems.count, forKey: ViewController.encodingKeyRedditItems)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        redditItems = coder.decodeObject(forKey: ViewController.encodingKeyRedditItems) as! [RedditItem]
    }
    
    override func applicationFinishedRestoringState() {
        print("Finished restoring everything.")
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = redditItems[indexPath.row]
        item.isOpen = true
        let detailVC = DetailViewController(item: item)
        detailVC.view.backgroundColor = UIColor.white
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return redditItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? TableViewCell
        
        let redditItem = redditItems[indexPath.row]
        
        cell?.configureteCell(item: redditItem)
        
        return cell!
    }
}



