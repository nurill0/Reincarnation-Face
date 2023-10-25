//
//  CollectionPreviewVC.swift
//  Reincarnation Face
//
//  Created by Nurillo Domlajonov on 26/10/23.
//

import UIKit
import FirebaseDatabaseInternal

class CollectionPreviewVC: BaseVC {
    
    
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
    
    
    lazy var optionBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "optionBtn"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(openOption), for: .touchUpInside)
        
        return btn
    }()
    
    
    lazy var optionView: UIView = {
        let vv = UIView()
        vv.translatesAutoresizingMaskIntoConstraints = false
        vv.backgroundColor = .white
        vv.isHidden = true
        
        return vv
    }()
    
    
    lazy var shareBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "shareBtn"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)
        
        return btn
    }()
    
    
    lazy var deleteBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "deleteBtn"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(didTapDelete), for: .touchUpInside)
        
        return btn
    }()
    
    
    lazy var deleteViewImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "deleteView")
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isHidden = true
        img.isUserInteractionEnabled = true
        
        return img
    }()
    
    lazy var yesBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "yesBtn"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.tag = 0
        btn.addTarget(self, action: #selector(deleteOrNot(sender:)), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var noBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "noBtn"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.tag = 1
        btn.addTarget(self, action: #selector(deleteOrNot(sender:)), for: .touchUpInside)
        
        return btn
    }()
    
    var isOpenedOption = false
    var isOpenedDeleteView = false
    var index = 0
    let uDManager = UserDefaultsManager.shared
    let database = Database.database().reference(fromURL:  "https://reincarnation-face-default-rtdb.firebaseio.com")
    
}



//MARK: life cycle
extension CollectionPreviewVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}



//MARK: actions
extension CollectionPreviewVC {
    
    @objc func openOption(){
        isOpenedOption.toggle()
        if isOpenedOption {
            optionView.isHidden = false
        }else{
            optionView.isHidden = true
        }
    }
    
    
    @objc func didTapShare(){
        guard let image = imageView.image else {
            print("No image found in the image view")
            return
        }
        
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    
    @objc func didTapDelete(){
        isOpenedDeleteView.toggle()
        if isOpenedDeleteView {
            deleteViewImage.isHidden = false
        }else{
            deleteViewImage.isHidden = true
        }
    }
    
    
    @objc func deleteOrNot(sender: UIButton){
        switch sender.tag {
        case 0: 
            print("yes btn tappaed")
            let usernameRef =  Database.database().reference().child("\(index+1)")
            usernameRef.removeValue()
            self.presentingViewController?.presentingViewController?.dismiss(animated: false)
        case 1:
            print("no btn tappaed")
        default: print("no thing")
        }
        isOpenedDeleteView = false
        if isOpenedDeleteView {
            deleteViewImage.isHidden = false
        }else{
            deleteViewImage.isHidden = true
        }
    }
    
}



//MARK: ui
extension CollectionPreviewVC {
    
    fileprivate func setupUI(){
        optionBtnConst()
        frameImgConst()
        imageViewConst()
        optionViewConst()
        shareBtnConst()
        deleteBtnConst()
        deleteViewConst()
        yesBtnConst()
        noBtnConst()
    }
    
    
    fileprivate func optionBtnConst(){
        view.addSubview(optionBtn)
        optionBtn.top(view.safeAreaLayoutGuide.topAnchor, 20)
        optionBtn.right(view.rightAnchor, -15)
        optionBtn.height(60)
        optionBtn.width(60)
    }
    
    
    fileprivate func frameImgConst(){
        view.addSubview(imageFrameView)
        imageFrameView.top(backBtn.bottomAnchor, 120)
        imageFrameView.right(view.rightAnchor, -20)
        imageFrameView.left(view.leftAnchor, 20)
        imageFrameView.bottom(view.centerYAnchor, 180)
    }
    
    
    fileprivate func imageViewConst(){
        imageFrameView.addSubview(imageView)
        imageView.top(imageFrameView.topAnchor, 20)
        imageView.bottom(imageFrameView.bottomAnchor, -20)
        imageView.right(imageFrameView.rightAnchor, -20)
        imageView.left(imageFrameView.leftAnchor, 20)
    }
    
    
    fileprivate func optionViewConst(){
        view.addSubview(optionView)
        optionView.top(optionBtn.bottomAnchor, 10)
        optionView.right(view.rightAnchor, -40)
        optionView.height(120)
        optionView.width(250)
    }
    
    
    fileprivate func shareBtnConst(){
        optionView.addSubview(shareBtn)
        shareBtn.top(optionView.topAnchor, 10)
        shareBtn.left(optionView.leftAnchor, 10)
        shareBtn.right(optionView.rightAnchor, -10)
        shareBtn.height(50)
    }
    
    
    fileprivate func deleteBtnConst(){
        optionView.addSubview(deleteBtn)
        deleteBtn.top(shareBtn.bottomAnchor, 10)
        deleteBtn.left(optionView.leftAnchor, 10)
        deleteBtn.right(optionView.rightAnchor, -10)
        deleteBtn.height(50)
    }
    
    
    fileprivate func deleteViewConst(){
        view.addSubview(deleteViewImage)
        deleteViewImage.top(optionBtn.bottomAnchor, 40)
        deleteViewImage.right(view.rightAnchor, -20)
        deleteViewImage.left(view.leftAnchor, 20)
        deleteViewImage.height(180)
    }
    
    
    fileprivate func yesBtnConst(){
        deleteViewImage.addSubview(yesBtn)
        yesBtn.bottom(deleteViewImage.bottomAnchor, -30)
        yesBtn.right(deleteViewImage.centerXAnchor, -20)
        yesBtn.height(50)
        yesBtn.width(100)
    }
    
    
    fileprivate func noBtnConst(){
        deleteViewImage.addSubview(noBtn)
        noBtn.bottom(deleteViewImage.bottomAnchor, -30)
        noBtn.left(deleteViewImage.centerXAnchor, 20)
        noBtn.height(50)
        noBtn.width(100)
    }
    
    
}

