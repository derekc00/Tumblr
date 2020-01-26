//
//  PhotosViewController.swift
//  TumblrLab
//
//  Created by Lily Pham on 4/7/19.
//  Copyright © 2019 Lily Pham. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    // Initialize to empty array so we don't worry about it being nil later
    var posts: [[String: Any]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        getPosts()

        // Do any additional setup after loading the view.
    }
    
    func getPosts() {
        API().getPosts() { (posts) in
            if let posts = posts {
                self.posts = posts
                self.tableView.reloadData()
            }
        }
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoCell
        let post = posts[indexPath.row]
        
        if let photos = post["photos"] as? [[String: Any]] {
        
            let photo = photos[0]
            
            let originalSize = photo["original_size"] as! [String:Any]
            
            let urlString = originalSize["url"] as! String
            
            let url = URL(string: urlString)
            
            cell.photoView.af_setImage(withURL: url!)
            

        }
        
        return cell
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
