//
//  BeginVC.swift
//  Reincarnation Face
//
//  Created by Nurillo Domlajonov on 25/10/23.
//

import UIKit

class BeginVC: UIViewController {
    
    lazy var bgImgView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "beginBG")
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        
        return img
    }()
    
    
    lazy var hiImgView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "hiImg")
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        
        return img
    }()
    
    
    lazy var descTxtView: UITextView = {
        let txt = UITextView()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.text = desc
        txt.textColor = .white
        txt.showsVerticalScrollIndicator = false
        txt.isEditable = false
        txt.font = UIFont(name: "Gluten-Medium", size: 25)
        txt.backgroundColor = .clear
        txt.textAlignment = .center
        
        return txt
    }()
    
    lazy var continueBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "continueBtn"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(didTapContinueBtn), for: .touchUpInside)
        
        return btn
    }()

    let userdefaults = UserDefaultsManager.shared



}



//MARK: life cycle + actions
extension BeginVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    @objc func didTapContinueBtn(){
        let vc = MenuVC()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true) {
            self.userdefaults.saveNickName(nickName: "entred")
        }
    }
    
}



//MARK: UI
extension BeginVC {
    
    fileprivate func setupUI(){
        bgImgViewConst()
        hiImgViewConst()
        continueBtnConst()
        descTextViewConst()
    }
    
    
    fileprivate func bgImgViewConst(){
        view.addSubview(bgImgView)
        bgImgView.top(view.topAnchor)
        bgImgView.bottom(view.bottomAnchor)
        bgImgView.left(view.leftAnchor)
        bgImgView.right(view.rightAnchor)
    }
    
    fileprivate func hiImgViewConst(){
        view.addSubview(hiImgView)
        hiImgView.top(view.safeAreaLayoutGuide.topAnchor, 10)
        hiImgView.centerX(view.centerXAnchor)
        hiImgView.height(80)
        hiImgView.width(100)
    }
    
    fileprivate func continueBtnConst(){
        view.addSubview(continueBtn)
        continueBtn.bottom(view.safeAreaLayoutGuide.bottomAnchor, -15)
        continueBtn.centerX(view.centerXAnchor)
        continueBtn.height(90)
        continueBtn.width(200)
    }
    
    fileprivate func descTextViewConst(){
        view.addSubview(descTxtView)
        descTxtView.top(hiImgView.bottomAnchor, 10)
        descTxtView.bottom(continueBtn.topAnchor, -10)
        descTxtView.right(view.rightAnchor, -10)
        descTxtView.left(view.leftAnchor, 10)
    }
    
}

