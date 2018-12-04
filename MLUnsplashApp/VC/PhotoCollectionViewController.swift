//
//  PhotoCollectionViewController.swift
//  MLUnsplashApp
//
//  Created by Simeng Liu on 4/12/18.
//  Copyright © 2018 Simeng Liu. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import SVProgressHUD

class PhotoCollectionViewController: UIViewController {
    
    @IBOutlet var photoCollectionView: UICollectionView!
    var width: CGFloat!
    var images: Array<UIImage>! = []
    var imagesData = NSMutableArray()
    var pageIndex = 1
    var fetchingMore = false
    
    //MARK: --life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.photoCollectionView.backgroundColor = UIColor.white
        self.photoCollectionView.alwaysBounceVertical = true
        getPhotoList(page:pageIndex)
    }
    
    func loadMore () {
        
        SVProgressHUD.show()
        getPhotoList(page: pageIndex)
        
    }
    // MARK: - Setup layout
    func waterFallLayout(imagesData:NSMutableArray) {
        width = (view.bounds.size.width - 20)/3
        let layout = WaterFlowViewLayout()
        
        guard imagesData.count > 0 else {
            print("no image fetched")
            return
        }
        
        for i in 0..<imagesData.count{
            let photoData = imagesData[i] as! PhotoData
            let url = URL(string: photoData.thumb!)
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            let image = UIImage(data: data!)
            images.append(image!)
        }
        layout.setSize = {
            return self.images
        }
        
        print("images:\(images.count)")
        self.photoCollectionView.collectionViewLayout = layout
        self.photoCollectionView.delegate = self
        self.photoCollectionView.dataSource = self
        
    }
    // MARK: - getData
    func getPhotoList(page:Int) {
        
        SVProgressHUD.show()
        
        let manager =  PhotoRequestManager.init(path: API.featuredPath, qureryName: "page", queryValue: "\(page)")
        
        manager.requestPhoto(url: manager.fullURL) { (value, error) in
            guard error == nil else {
                
                let alert = getSimpleAlert (titleString: "error", messgae:"\(error?.localizedDescription ?? "Unknown error")")
                
                self.present(alert, animated: true, completion: {
                    SVProgressHUD.dismiss()
                })
                return
            }
            
            let resultArray = value as! NSArray
            if resultArray.count == 0 {
                return
            }
            
            let newImagesData = NSMutableArray()
            for index in 0..<resultArray.count{
                
                let photo = Mapper<PhotoData>().map(JSONObject: resultArray[index])
                
                self.imagesData.add(photo ?? photo as Any)
                newImagesData.add(photo ?? photo as Any)
            }
            
            print("imagesData:\(self.imagesData.count)")
            guard self.imagesData.count>0 else{
                print("no images")
                return
            }
            
            self.waterFallLayout(imagesData: newImagesData)
            
            self.photoCollectionView.collectionViewLayout.invalidateLayout()
            SVProgressHUD.dismiss()
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetail" {
            
            let nextCV = segue.destination as! PhotoDetailViewController
            nextCV.photoId = sender as? String
        }
    }
}

extension PhotoCollectionViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldUpdateFocusIn context: UICollectionViewFocusUpdateContext) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath as IndexPath)
        
        let imageView = UIImageView(frame: cell.bounds)
        
        imageView.image = images[indexPath.row]
        
        imageView.layer.borderWidth = 6
        imageView.layer.borderColor = UIColor.white.cgColor
        
        let bgView = UIView(frame:cell.bounds)
        bgView.layer.borderColor = UIColor.black.cgColor
        bgView.layer.borderWidth = 3
        
        bgView.addSubview(imageView)
        cell.backgroundView = bgView
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        _ = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath as IndexPath)
        
        let photo = self.imagesData[indexPath.item] as! PhotoData
        performSegue(withIdentifier: "toDetail", sender: photo.coverID)
        
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height {
            if !fetchingMore{
                begainBatchFetch()
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.fetchingMore = false
    }
    
    func begainBatchFetch() {
        
        fetchingMore = true
        pageIndex += 1
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
            self.getPhotoList(page: self.pageIndex)
        }
    }
}

