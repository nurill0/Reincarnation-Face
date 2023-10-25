//
//  ImageCollectionsCell.swift
//  Reincarnation Face
//
//  Created by Nurillo Domlajonov on 26/10/23.
//

import UIKit

class ImageCollectionsCell: UICollectionViewCell {
    
    static let id = "imageCollectionsCell"
    
    lazy var imageFrameView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "imgFrame")
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        
        return img
    }()
    
    
    lazy var imageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "")
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        
        return img
    }()
    
    var activityIndicator: UIActivityIndicatorView!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.backgroundColor = .white
        activityIndicator.center = imageFrameView.center
        self.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func initItems(imgUrl: String){
        imageView.setImageFrom(imgUrl)
        activityIndicator.stopAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func setupUI(){
        imgFrameConst()
        imgViewConst()
    }
    
    
    fileprivate func imgFrameConst(){
        self.addSubview(imageFrameView)
        imageFrameView.top(self.topAnchor)
        imageFrameView.bottom(self.bottomAnchor)
        imageFrameView.right(self.rightAnchor)
        imageFrameView.left(self.leftAnchor)
    }
    
    
    fileprivate func imgViewConst(){
        self.addSubview(imageView)
        imageView.top(imageFrameView.topAnchor, 10)
        imageView.bottom(imageFrameView.bottomAnchor, -10)
        imageView.right(imageFrameView.rightAnchor, -15)
        imageView.left(imageFrameView.leftAnchor, 15)
    }
    
    
}
