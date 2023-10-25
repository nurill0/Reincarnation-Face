//
//  FeedPreviewVC.swift
//  Reincarnation Face
//
//  Created by Nurillo Domlajonov on 26/10/23.
//

import UIKit

class FeedPreviewVC: BaseVC {

 
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
    
    
    lazy var likeCountView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "likeCount")
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        
        return img
    }()
    
    lazy var likeCountLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "0 👍🏻"
        lbl.textColor = .black
        lbl.font = UIFont(name: "Gluten-Medium", size: 18)
        lbl.backgroundColor = .clear
        lbl.textAlignment = .center

        return lbl
    }()
  
    lazy var dislikeCountView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "likeCount")
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        
        return img
    }()
    
    lazy var dislikeCountLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "0 👎🏻"
        lbl.textColor = .black
        lbl.font = UIFont(name: "Gluten-Medium", size: 18)
        lbl.backgroundColor = .clear
        lbl.textAlignment = .center

        return lbl
    }()

    
    lazy var likeBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "unselectedLikeBtn"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.tag = 1
        btn.addTarget(self, action: #selector(didTapLikeDislikeBtn(sender: )), for: .touchUpInside)

        return btn
    }()
    
    lazy var dislikeBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "unselectedDislikeBtn"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.tag = 2
        btn.addTarget(self, action: #selector(didTapLikeDislikeBtn(sender: )), for: .touchUpInside)
        
        return btn
    }()
    
    var likeCount = 0 {
        didSet {
            likeCountLbl.text = "\(likeCount) 👍🏻"
        }
    }
    var dislikeCount = 0 {
        didSet {
            dislikeCountLbl.text = "\(dislikeCount) 👎🏻"
        }
    }
    var index = 0
    let db = DatabaseManager.shared
}



//MARK: life cycle
extension FeedPreviewVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}



//MARK: action
extension FeedPreviewVC {
    
    @objc func didTapLikeDislikeBtn(sender: UIButton){
        switch sender.tag {
        case 1: likeAction()
        case 2: dislikeAction()
        default: print("error")
        }
        
    }
    
    func likeAction(){
        likeCount+=1
        showAlert(likes: likeCount, dislikes: dislikeCount)
        likeBtn.setImage(UIImage(named: "selectedLikeBtn"), for: .normal)
        dislikeBtn.setImage(UIImage(named: "unselectedDislikeBtn"), for: .normal)
        likeCountLbl.text = "\(likeCount) 👍🏻"
        dislikeCountLbl.text = "\(dislikeCount) 👎🏻"
    }
    
    func dislikeAction(){
        dislikeCount+=1
        showAlert(likes: likeCount, dislikes: dislikeCount)
        dislikeBtn.setImage(UIImage(named: "selectedDislikeBtn"), for: .normal)
        likeBtn.setImage(UIImage(named: "unselectedLikeBtn"), for: .normal)
        likeCountLbl.text = "\(likeCount) 👍🏻"
        dislikeCountLbl.text = "\(dislikeCount) 👎🏻"
    }
    
    func showAlert(likes: Int, dislikes: Int) {
        let alert = UIAlertController(title: "Saved", message: "Your rating successfully saved", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert  in
            self.db.addLike(likes: likes,count: self.index)
            self.db.addDislike(dislikes: dislikes, count: self.index)
            self.presentingViewController?.presentingViewController?.dismiss(animated: false) {
            }
        }))
        present(alert, animated: true)
    }
}



//MARK: ui
extension FeedPreviewVC {
    
    
    fileprivate func setupUI(){
        frameImgConst()
        imageViewConst()
        likeCountViewConst()
        dislikeCountViewConst()
        likeCountLblConst()
        dislikeCountLblConst()
        likeBtnConst()
        dislikeBtnConst()
    }
    
    
    fileprivate func frameImgConst(){
        view.addSubview(imageFrameView)
        imageFrameView.top(backBtn.bottomAnchor, -20)
        imageFrameView.right(view.rightAnchor, -20)
        imageFrameView.left(view.leftAnchor, 20)
        imageFrameView.bottom(view.centerYAnchor, 170)
    }
    
    
    fileprivate func imageViewConst(){
        imageFrameView.addSubview(imageView)
        imageView.top(imageFrameView.topAnchor, 80)
        imageView.bottom(imageFrameView.bottomAnchor, -80)
        imageView.right(imageFrameView.rightAnchor, -20)
        imageView.left(imageFrameView.leftAnchor, 20)
    }
    
    
    fileprivate func likeCountViewConst(){
        view.addSubview(likeCountView)
        likeCountView.top(imageFrameView.bottomAnchor, -60)
        likeCountView.left(imageFrameView.leftAnchor, 40)
        likeCountView.width(70)
        likeCountView.height(60)
    }
    
    
    fileprivate func likeCountLblConst(){
        likeCountView.addSubview(likeCountLbl)
        likeCountLbl.centerY(likeCountView.centerYAnchor, -5)
        likeCountLbl.left(likeCountView.leftAnchor, 5)
        likeCountLbl.right(likeCountView.rightAnchor, -5)
    }
    
    
    fileprivate func dislikeCountViewConst(){
        view.addSubview(dislikeCountView)
        dislikeCountView.top(imageFrameView.bottomAnchor, -60)
        dislikeCountView.right(imageFrameView.rightAnchor, -40)
        dislikeCountView.width(70)
        dislikeCountView.height(60)
    }
    
    
    fileprivate func dislikeCountLblConst(){
        dislikeCountView.addSubview(dislikeCountLbl)
        dislikeCountLbl.centerY(dislikeCountView.centerYAnchor, -5)
        dislikeCountLbl.left(dislikeCountView.leftAnchor, 5)
        dislikeCountLbl.right(dislikeCountView.rightAnchor, -5)
    }
    
    
    fileprivate func likeBtnConst(){
        view.addSubview(likeBtn)
        likeBtn.top(likeCountView.bottomAnchor, 30)
        likeBtn.left(likeCountView.leftAnchor)
        likeBtn.height(70)
        likeBtn.width(70)
    }
    
    
    fileprivate func dislikeBtnConst(){
        view.addSubview(dislikeBtn)
        dislikeBtn.top(dislikeCountView.bottomAnchor, 30)
        dislikeBtn.right(dislikeCountView.rightAnchor)
        dislikeBtn.height(70)
        dislikeBtn.width(70)
    }
}
