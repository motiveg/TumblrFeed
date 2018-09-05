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

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var posts: [[String: Any]] = []
    var refreshControl: UIRefreshControl!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(PhotosViewController.didPullToRefresh(_:)), for: .valueChanged)
        
        tableView.insertSubview(refreshControl, at: 0)
        tableView.dataSource = self
        
        fetchPosts()
    }
    
    func fetchPosts() {
        
        // Network request snippet
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                
                self.refreshControl.endRefreshing()
                HUD.hide()
                
                // Pop up alert upon (network) error
                // Source: https://www.ioscreator.com/tutorials/display-alert-ios-tutorial-ios10
                let alertController = UIAlertController(title: "Error", message:
                    error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
                self.present(alertController, animated: true, completion: nil)
                
                print(error.localizedDescription)
                
            } else if let data = data {
                
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                print(dataDictionary)
                
                // Get the dictionary from the response key
                let responseDictionary = dataDictionary["response"] as! [String: Any]
                // Store the returned array of dictionaries in our posts property
                self.posts = responseDictionary["posts"] as! [[String: Any]]
                
                self.tableView.reloadData()
                HUD.flash(.success, delay: 0.35)
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("Number of posts: \(posts.count)")
        return posts.count // temp
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let post = posts[indexPath.row]
        
        // use a default image before trying to get the poster image
        let defaultImageString = "https://raw.githubusercontent.com/motiveg/TumblrFeed/master/ImageNotLoaded.png"
        let defaultImageURL = URL(string: defaultImageString)!
        cell.photoCellImageView.af_setImage(withURL: defaultImageURL)
        
        if let photos = post["photos"] as? [[String: Any]] {
            
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String: Any]
            let urlString = originalSize["url"] as! String
            let url = URL(string: urlString)
            
            cell.photoCellImageView.af_setImage(withURL: url!)
            
            // https://raw.githubusercontent.com/motiveg/TumblrFeed/master/ImageNotLoaded.png
        }
        
        return cell
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        HUD.show(.progress)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.fetchPosts()
            self.refreshControl.endRefreshing()
        }
    }

}
