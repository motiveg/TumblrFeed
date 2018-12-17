//
//  PhotosViewController.swift
//  TumblrFeed
//
//  Created by Brian Casipit on 9/5/18.
//  Copyright © 2018 Brian Casipit. All rights reserved.
//

import UIKit
import AlamofireImage
import PKHUD

class PhotosViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tumblrPosts: [TumblrPost] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(PhotosViewController.didPullToRefresh(_:)), for: .valueChanged)
        
        tableView.insertSubview(refreshControl, at: 0)
        tableView.dataSource = self
        
        fetchTumblrPosts()
    }
    
    func fetchTumblrPosts() {
        TumblrAPI().fetchPosts() { (tumblrPosts: [TumblrPost]?, error: Error?) in
            if let tumblrPosts = tumblrPosts {
                self.tumblrPosts = tumblrPosts
            }
            else {
                self.refreshControl.endRefreshing()
                HUD.hide()
                
                // Pop up alert upon (network) error
                // Source: https://www.ioscreator.com/tutorials/display-alert-ios-tutorial-ios10
                let alertController = UIAlertController(title: "Error", message:
                    error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
                self.present(alertController, animated: true, completion: nil)
                
                print("Error: \(error ?? " " as! Error)")
            }
            // NOTE: relocate the below 2 methods if needed
            self.tableView.reloadData()
            HUD.flash(.success, delay: 0.35)
        } // end of closure
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        HUD.show(.progress)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.fetchTumblrPosts()
            self.refreshControl.endRefreshing()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PhotoDetailsSegue" {
            let vc = segue.destination as! PhotoDetailsViewController
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)!
            let tumblrPost = tumblrPosts[indexPath.section]
            vc.tumblrPost = tumblrPost
        }
    }
    
}

extension PhotosViewController: UITableViewDelegate {
    // Add methods if needed
}

extension PhotosViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("Number of posts: \(section)")
        //return posts.count
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tumblrPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let tumblrPost = tumblrPosts[indexPath.section]
        
        let photoURL = URL(string: tumblrPost.original_size_photo_url!)
        cell.photoCellImageView.af_setImage(withURL: photoURL!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        headerView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        
        let profileView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 15;
        profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).cgColor
        profileView.layer.borderWidth = 1;
        
        // Set the avatar
        profileView.af_setImage(withURL: URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/avatar")!)
        headerView.addSubview(profileView)
        
        // Add a uilabel for the date
        let dateLabel = UILabel(frame: CGRect(x: 50, y: 10, width: 260, height: 30))
        dateLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
        dateLabel.text = TumblrPost.convertTimeZone(dateTime: tumblrPosts[section].date!)
        headerView.addSubview(dateLabel)
        
        return headerView
    }
    
}
