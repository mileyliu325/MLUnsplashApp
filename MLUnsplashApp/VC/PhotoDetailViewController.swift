//
//  PhotoDetailViewController.swift
//  MLUnsplashApp
//
//  Created by Simeng Liu on 4/12/18.
//  Copyright © 2018 Simeng Liu. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import SDWebImage
import ObjectMapper

class PhotoDetailViewController: UIViewController {

    @IBOutlet var fullImageView: UIImageView!
    @IBOutlet var viewLabel: UILabel!
    @IBOutlet var downloadsLabel: UILabel!
    @IBOutlet var likesLabel: UILabel!
    @IBOutlet var sizeLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var downloadBtn: UIButton!
    var photoId : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let photoId = photoId {
            fetchPhotoDetail(id:photoId)
        }
        
        self.descriptionLabel.lineBreakMode = .byWordWrapping
        self.descriptionLabel.numberOfLines = 0
        self.dateLabel.lineBreakMode = .byWordWrapping
        self.downloadsLabel.numberOfLines = 0
        
    }
    @IBAction func closePage(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    func fetchPhotoDetail(id:String) {
        
        SVProgressHUD.show()
        
        let manager = PhotoRequestManager.init(path: API.photoPath, id: id)
        let url = manager.fullURL
        
        manager.requestPhoto(url: url) { (value, error) in
            
            guard error == nil else {
                print("Request Error:\(error)")
               
                let alert = getSimpleAlert (titleString: "error", messgae:"\(String(describing: error?.localizedDescription))")
                
                self.present(alert, animated: true,completion: {
                     SVProgressHUD.dismiss()
                })
                
              
                return
            }
            
            let photoDetail = Mapper<PhotoDetail>().map(JSONObject: value)
            
            self.fullImageView.sd_setImage(with: URL(string:(photoDetail?.full)!), placeholderImage: UIImage.init(named: "placeholder"), options: .continueInBackground, completed: nil)
            
            self.viewLabel.text = "\(photoDetail?.views! ?? 0)"
            self.downloadsLabel.text = "\(photoDetail?.downloads! ?? 0)"
            self.likesLabel.text = "\(photoDetail?.likes! ?? 0)"
            self.descriptionLabel.text = photoDetail?.description
            //todo date modified
            self.dateLabel.text = "Uploaded at:\(photoDetail?.created! ?? "N/A")"
            self.sizeLabel.text = "\(photoDetail?.width! ?? 0) * \(photoDetail?.height! ?? 0)"
            SVProgressHUD.dismiss()
            
        }
   
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
}
