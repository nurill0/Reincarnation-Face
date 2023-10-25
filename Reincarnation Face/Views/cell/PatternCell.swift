//
//  PatternCell.swift
//  Reincarnation Face
//
//  Created by Nurillo Domlajonov on 26/10/23.
//

import UIKit

class PatternCell: UICollectionViewCell {
    
    static let id = "patternCell"

    lazy var imageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "example")
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        
        return img
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initItem(imgName: String) {
        self.imageView.image = UIImage(named: imgName)
    }
    
    func initItems(imgUrl: String){
        imageView.setImageFrom(imgUrl)
    }
    
    fileprivate func setupUI(){
        imgViewConst()
    }
    

    
    fileprivate func imgViewConst(){
        self.addSubview(imageView)
        imageView.top(self.topAnchor)
        imageView.bottom(self.bottomAnchor)
        imageView.right(self.rightAnchor)
        imageView.left(self.leftAnchor)
    }
    
}
