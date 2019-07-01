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
    private let refreshControl = UIRefreshControl()
    
    /// Properties
    
    private let tableviewCellHeight: CGFloat = 305.0
    private let reuseIdentifier = "TableViewCell"
    private var redditItems = [RedditItem]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("ViewController_Screen_Title", comment: "")
        setupTableView()
        setupRefreshControl()
        setupActivityIndicator()
        getRedditItems()
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
    
}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return redditItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? TableViewCell
        return cell!
    }
}


