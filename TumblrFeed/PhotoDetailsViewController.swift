//
//  PhotoDetailsViewController.swift
//  TumblrFeed
//
//  Created by Brian Casipit on 9/5/18.
//  Copyright © 2018 Brian Casipit. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {

    @IBOutlet weak var photoDetailsImageView: UIImageView!
    
    var photoURL: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        photoDetailsImageView.af_setImage(withURL: photoURL)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
