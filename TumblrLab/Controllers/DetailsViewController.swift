//
//  DetailsViewController.swift
//  TumblrLab
//
//  Created by Derek Chang on 1/25/20.
//  Copyright © 2020 Derek Chang. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var detailImage: UIImageView!
    
//    need this property because prepare(for:) cannot access the @IBOutlet's of this destination controller bc they have't been setup yet.
    var incomingImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailImage.image = incomingImage
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
