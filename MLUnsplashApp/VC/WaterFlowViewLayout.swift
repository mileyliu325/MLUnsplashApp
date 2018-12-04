//
//  WaterFlowViewLayout.swift
//  MLUnsplashApp
//
//  Created by Simeng Liu on 4/12/18.
//  Copyright © 2018 Simeng Liu. All rights reserved.
//

import UIKit

class WaterFlowViewLayout: UICollectionViewLayout {
    //control cell size
    var setSize:()->(Array<UIImage>) = { return []}
    var queueNum: Int = 2 //colum num
    var hs: Array<CGFloat>!
    private var totalNum: Int!
    private var layoutAttributes: Array<UICollectionViewLayoutAttributes>!
    override func prepare() {
        super.prepare()
        hs = []
        for _ in 0..<queueNum {
            hs.append(5)
        }
        totalNum = collectionView?.numberOfItems(inSection: 0)
        layoutAttributes = []
        var indexpath: NSIndexPath!
        for index in 0..<totalNum {
            indexpath = NSIndexPath(row: index, section: 0)
            let attributes = layoutAttributesForItem(at: indexpath as IndexPath)
            layoutAttributes.append(attributes!)
        }
    }
    private let gap:CGFloat = 5//spacing between to column
    private var width:CGFloat!
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        width = (collectionView!.bounds.size.width-gap*(CGFloat(queueNum)-1))/CGFloat(queueNum)
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let sizes = setSize()
        attributes.size = CGSize(width: width, height: sizes[indexPath.row].size.height*width/sizes[indexPath.row].size.width)
        var nub:CGFloat = 0
        var h:CGFloat = 0
        (nub,h) = minH(hhs: hs)
        attributes.center = CGPoint(x:(nub+0.5)*(gap+width), y:h+(width/attributes.size.width*attributes.size.height+gap)/2)
        hs[Int(nub)] = h+width/attributes.size.width*attributes.size.height+gap
        return attributes
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes
    }
    
    
    override var collectionViewContentSize: CGSize {
        get {
            return CGSize(width: (collectionView?.bounds.width)!, height: maxH(hhs: hs))
        }
        set {
            self.collectionViewContentSize = newValue
        }
    }
    
    private func minH(hhs:Array<CGFloat>)->(CGFloat,CGFloat){
        var num = 0
        var min = hhs[0]
        for i in 1..<hhs.count{
            if min>hhs[i] {
                min = hhs[i]
                num = i
            }
        }
        return (CGFloat(num),min)
    }
    func maxH(hhs:Array<CGFloat>)->CGFloat{
        var max = hhs[0]
        for i in 1..<hhs.count{
            if max<hhs[i] {
                max = hhs[i]
            }
        }
        return max
    }
    
}
