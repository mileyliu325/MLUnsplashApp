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
            fetchPhotoDetail()
        }
        
        self.descriptionLabel.lineBreakMode = .byWordWrapping
        self.descriptionLabel.numberOfLines = 0
        
    }
    @IBAction func closePage(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    func fetchPhotoDetail(){
        
        SVProgressHUD.show()
        //todo change url
        let url = URL.init(string: "https://api.unsplash.com/photos/\(self.photoId!)?client_id=95f7082d453e177f4c98fbd99e7df1b975a3f0a8c3acae58941353fa9cd3ae7c")!
        
        Alamofire.request(url).validate()
            .responseJSON {response in
                switch response.result {
                case .success(let value):
                    
                    print("value:\(value)")
                    let photoDetail = Mapper<PhotoDetail>().map(JSONObject: value)
                    
                    self.fullImageView.sd_setImage(with:URL(string:(photoDetail?.full)!)
                        , completed: { (image, erro, cache, url) in
                            self.fullImageView.image = image
                    })
                    
                    self.viewLabel.text = "\(photoDetail?.views! ?? 0)"
                    self.downloadsLabel.text = "\(photoDetail?.downloads! ?? 0)"
                    self.likesLabel.text = "\(photoDetail?.likes! ?? 0)"
                    self.descriptionLabel.text = photoDetail?.description
                    self.dateLabel.text = photoDetail?.created
                    self.sizeLabel.text = "\(photoDetail?.width! ?? 0) * \(photoDetail?.height! ?? 0)"
                    SVProgressHUD.dismiss()
                    
                case .failure(let error):
                    print("Request Error:\(error)")
                    return
                }
        }
        
    }

    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
}
