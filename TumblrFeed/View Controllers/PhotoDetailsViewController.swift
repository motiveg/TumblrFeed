//
//  PhotoDetailsViewController.swift
//  TumblrFeed
//
//  Created by Brian Casipit on 9/5/18.
//  Copyright © 2018 Brian Casipit. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotoDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var tumblrPost: TumblrPost?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        self.navigationItem.title = tumblrPost?.title
        // TODO: set table view (and cell) to height of display height
        // OBJECTIVE: dynamically set the view height depending on the display
    }
    
}

extension PhotoDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoDetailCell", for: indexPath) as! PhotoDetailCell
        
        let imageURL = URL(string: tumblrPost!.original_size_photo_url!)
        cell.photoDetailImageView.af_setImage(withURL: imageURL!)
        
        if let date = tumblrPost?.date {
            cell.dateLabel.text = "  " + date + "  "
        } else {
            cell.dateLabel.text = ""
        }
        
        cell.captionTextView.text = tumblrPost?.caption
        
        return cell
    }

}
