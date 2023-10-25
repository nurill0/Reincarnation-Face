//
//  MenuVC.swift
//  Reincarnation Face
//
//  Created by Nurillo Domlajonov on 25/10/23.
//
import UIKit

class MenuVC: UIViewController {
    
    lazy var bgImgView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "menuBG")
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        
        return img
    }()
    
    
    lazy var collectionBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "1"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.tag = 1
        btn.addTarget(self, action: #selector(choosePages(sender: )), for: .touchUpInside)
        return btn
    }()
    
    
    lazy var patternBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "2"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.tag = 2
        btn.addTarget(self, action: #selector(choosePages(sender: )), for: .touchUpInside)
        return btn
    }()
    
    
    lazy var feedBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "3"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.tag = 3
        btn.addTarget(self, action: #selector(choosePages(sender: )), for: .touchUpInside)
        return btn
    }()
    
    
}



//MARK: life cycle + actions
extension MenuVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @objc func choosePages(sender: UIButton){
        var vc = UIViewController()
        switch sender.tag {
        case 1:
            vc = CollectionVC()
            collectionBtn.setImage(UIImage(named: "11"), for: .normal)
        case 2:
            vc = PatternVC()
            patternBtn.setImage(UIImage(named: "22"), for: .normal)
        case 3:
            vc = FeedVC()
            feedBtn.setImage(UIImage(named: "33"), for: .normal)
            
        default:  vc = MenuVC()
        }
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true) { [self] in
            collectionBtn.setImage(UIImage(named: "1"), for: .normal)
            patternBtn.setImage(UIImage(named: "2"), for: .normal)
            feedBtn.setImage(UIImage(named: "3"), for: .normal)
        }
    }
}



//MARK: UI
extension MenuVC {
    
    fileprivate func setupUI(){
        bgImgViewConst()
        patternBtnConst()
        collectionBtnConst()
        feedBtnConst()
    }
    
    
    fileprivate func bgImgViewConst(){
        view.addSubview(bgImgView)
        bgImgView.top(view.topAnchor)
        bgImgView.bottom(view.bottomAnchor)
        bgImgView.left(view.leftAnchor)
        bgImgView.right(view.rightAnchor)
    }
    
    
    fileprivate func collectionBtnConst(){
        view.addSubview(collectionBtn)
        collectionBtn.bottom(patternBtn.topAnchor, -80)
        collectionBtn.right(view.rightAnchor, -20)
        collectionBtn.left(view.leftAnchor, 40)
        collectionBtn.height(100)
    }
    
    
    fileprivate func patternBtnConst(){
        view.addSubview(patternBtn)
        patternBtn.centerY(view.centerYAnchor, -20)
        patternBtn.right(view.rightAnchor, -50)
        patternBtn.left(view.leftAnchor, 15)
        patternBtn.height(100)
    }
    
    
    fileprivate func feedBtnConst(){
        view.addSubview(feedBtn)
        feedBtn.top(view.centerYAnchor, 110)
        feedBtn.right(view.rightAnchor, -15)
        feedBtn.left(view.leftAnchor, 50)
        feedBtn.height(100)
    }
    
    
}


