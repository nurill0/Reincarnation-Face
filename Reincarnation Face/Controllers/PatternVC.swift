//
//  PatternVC.swift
//  Reincarnation Face
//
//  Created by Nurillo Domlajonov on 26/10/23.
//

import UIKit

class PatternVC: BaseVC {

    lazy var rightArrowBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "rightArrow"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.tag = 1
        btn.addTarget(self, action: #selector(didTapArrowButtons(sender: )), for: .touchUpInside)

        return btn
    }()
    
    lazy var leftArrowBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "leftArrow"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.tag = 2
        btn.addTarget(self, action: #selector(didTapArrowButtons(sender: )), for: .touchUpInside)

        return btn
    }()
    
    
    lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "animals"
        lbl.textColor = .white
        lbl.font = UIFont(name: "Gluten-Medium", size: 38)
        lbl.backgroundColor = .clear
        lbl.textAlignment = .center

        return lbl
    }()
    
    lazy var patternCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        collection.register(PatternCell.self, forCellWithReuseIdentifier: PatternCell.id)
        
        return collection
    }()
    
    let data = PatternData()
    var patternCount = 0 {
        didSet {
            patternCollectionView.reloadData()
        }
    }

}



//MARK: life cycle
extension PatternVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}



//MARK: actions
extension PatternVC {
    
    @objc func didTapArrowButtons(sender: UIButton){
        print(patternCount)
        switch sender.tag {
        case 1: didTapRight()
        case 2: didTapLeft()
        default: print("error")
        }
        patternCollectionView.reloadData()
    }
    
    func didTapRight(){
        if patternCount != 5 && patternCount >= 0 {
            patternCount+=1
            titleLbl.text = data.getTitle(index: patternCount)
        }else{
            patternCount = 5
        }
    }
    
    func didTapLeft(){
       
        if patternCount<=5 && patternCount != 0 {
            patternCount-=1
            titleLbl.text = data.getTitle(index: patternCount)
        }else{
            patternCount = 0
        }
    }
}



//MARK: collectionview delegate + data source
extension PatternVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch patternCount {
        case 0: return data.getAnimalsSize()
        case 1: return data.getPinupSize()
        case 2: return data.getRockSize()
        case 3: return data.getFunnySize()
        case 4: return data.getKidsSize()
        case 5: return data.getScarySize()
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PatternCell.id, for: indexPath) as! PatternCell
        switch patternCount {
        case 0: cell.initItem(imgName: data.getAnimals(index: indexPath.item))
        case 1: cell.initItem(imgName: data.getPinup(index: indexPath.item))
        case 2: cell.initItem(imgName: data.getRock(index: indexPath.item))
        case 3: cell.initItem(imgName: data.getFunny(index: indexPath.item))
        case 4: cell.initItem(imgName: data.getKids(index: indexPath.item))
        case 5: cell.initItem(imgName: data.getScary(index: indexPath.item))
        default: print("nothing")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width-50)/3, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PhotoVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        switch patternCount {
        case 0: vc.initImages(img: data.getAnimals(index: indexPath.item))
        case 1: vc.initImages(img: data.getPinup(index: indexPath.item))
        case 2: vc.initImages(img: data.getRock(index: indexPath.item))
        case 3: vc.initImages(img: data.getFunny(index: indexPath.item))
        case 4: vc.initImages(img: data.getKids(index: indexPath.item))
        case 5: vc.initImages(img: data.getScary(index: indexPath.item))
        default: print("nothing")
        }
        present(vc, animated: true)
    }
    
 
}



//MARK: UI
extension PatternVC {
    
    fileprivate func setupUI(){
        bgImgView.image = UIImage(named: "PatternBG")
        leftArrowBtnConst()
        rightArrowBtnConst()
        titleLblConst()
        patternCollectionVConst()
    }
    
    fileprivate func leftArrowBtnConst(){
        view.addSubview(leftArrowBtn)
        leftArrowBtn.top(backBtn.bottomAnchor, 10)
        leftArrowBtn.left(backBtn.leftAnchor, 10)
        leftArrowBtn.width(30)
        leftArrowBtn.height(40)
    }
    
    fileprivate func rightArrowBtnConst(){
        view.addSubview(rightArrowBtn)
        rightArrowBtn.top(backBtn.bottomAnchor, 10)
        rightArrowBtn.right(view.rightAnchor, -15)
        rightArrowBtn.width(30)
        rightArrowBtn.height(40)
    }
    
    fileprivate func titleLblConst(){
        view.addSubview(titleLbl)
        titleLbl.centerY(rightArrowBtn.centerYAnchor)
        titleLbl.left(leftArrowBtn.rightAnchor, 5)
        titleLbl.right(rightArrowBtn.leftAnchor, -5)
    }
    
    fileprivate func patternCollectionVConst(){
        view.addSubview(patternCollectionView)
        patternCollectionView.top(rightArrowBtn.bottomAnchor, 10)
        patternCollectionView.right(view.rightAnchor, -15)
        patternCollectionView.left(view.leftAnchor, 15)
        patternCollectionView.bottom(view.safeAreaLayoutGuide.bottomAnchor)
    }
    
}
