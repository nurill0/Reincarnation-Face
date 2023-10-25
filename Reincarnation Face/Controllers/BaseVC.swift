//
//  BaseVC.swift
//  Reincarnation Face
//
//  Created by Nurillo Domlajonov on 26/10/23.
//

import UIKit

class BaseVC: UIViewController {
    
    lazy var bgImgView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "baseBGImg")
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        
        return img
    }()
    
    
    lazy var backBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "backBtn"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(didTapBackBtn), for: .touchUpInside)
        
        return btn
    }()
    
    
    

}


extension BaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBaseUI()
    }
    
    
    @objc func didTapBackBtn(){
        dismiss(animated: true)
    }
    
}

extension BaseVC {
    
    fileprivate func setupBaseUI(){
        bgImgViewConst()
        backBtnConst()
    }
    
    
    fileprivate func bgImgViewConst(){
        view.addSubview(bgImgView)
        bgImgView.top(view.topAnchor)
        bgImgView.bottom(view.bottomAnchor)
        bgImgView.left(view.leftAnchor)
        bgImgView.right(view.rightAnchor)
    }
    
    fileprivate func backBtnConst(){
        view.addSubview(backBtn)
        backBtn.top(view.safeAreaLayoutGuide.topAnchor, 20)
        backBtn.left(view.leftAnchor, 15)
        backBtn.height(60)
        backBtn.width(60)
    }
    

}

