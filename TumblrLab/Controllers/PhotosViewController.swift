//
//  PhotosViewController.swift
//  TumblrLab
//
//  Created by Derek Chang on 1/25/20.
//  Copyright © 2019 Derek Chang. All rights reserved.
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsSegue" {
            let cell = sender as! PhotoCell
            if let indexPath = tableView.indexPath(for: cell){
                let detailsController = segue.destination as! DetailsViewController
                detailsController.incomingImage = cell.photoView.image!
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
    
    //only need one row because the info tag and picture are both in one cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //each section contains info tag and picture in one cell
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoCell
        let post = posts[indexPath.section]
        
        if let photos = post["photos"] as? [[String: Any]] {
        
            let photo = photos[0]
            
            let originalSize = photo["original_size"] as! [String:Any]
            
            let urlString = originalSize["url"] as! String
            
            let url = URL(string: urlString)
            
            cell.photoView.af_setImage(withURL: url!)
            
        }
        
        return cell
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

        //Set the title of the blog
        let label = UILabel(frame: CGRect(x: 50, y: 5, width: 260, height: 45))
        label.textAlignment = NSTextAlignment.left
        let post = posts[section]
        
        if let blogName = post["blog_name"] as? String {
            label.text = blogName
        }
        headerView.addSubview(label)

        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        footerView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        
        let post = posts[section]
        //set the timestamp
        let timeStamp = UILabel(frame: CGRect(x: 10, y: 5, width: 60, height: 45))
        let rawDate = post["date"] as! String
        let tumblrDateFormat = "yyyy-MM-dd HH:mm:ss ZZZZ"
        timeStamp.textAlignment = NSTextAlignment.left
        timeStamp.text =  dateHelper().getSimpleDate(rawDateString: rawDate, format: tumblrDateFormat)
        timeStamp.adjustsFontSizeToFitWidth = true
        
        footerView.addSubview(timeStamp)
        
        return footerView
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
}
