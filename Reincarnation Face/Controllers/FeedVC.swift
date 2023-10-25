//
//  FeedVC.swift
//  Reincarnation Face
//
//  Created by Nurillo Domlajonov on 26/10/23.
//

import UIKit
import FirebaseDatabaseInternal

class FeedVC: BaseVC {
    
    lazy var imagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        collection.register(ImageCollectionsCell.self, forCellWithReuseIdentifier: ImageCollectionsCell.id)
        
        return collection
    }()
    
    
    lazy var addImgBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "addImgBtn"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(didTapAddImg), for: .touchUpInside)
        
        return btn
    }()
    
    let uDManager = UserDefaultsManager.shared
    let database = Database.database().reference(fromURL:  "https://reincarnation-face-default-rtdb.firebaseio.com")
    
    
    var imgUrls: [String] = [] {
        didSet{
            imagesCollectionView.reloadData()
        }
    }
    
    var likes: [Int] = []
    var disLikes: [Int] = []
    var refreshControl = UIRefreshControl()
    var itemscount: Int = 0 {
        didSet{
            imagesCollectionView.reloadData()
        }
    }
}



//MARK: life cycle
extension FeedVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        willDeleteItem()
        getImagesFromDB()
        setupUI()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        imagesCollectionView.refreshControl = refreshControl
        
    }
    

}



//MARK: actions
extension FeedVC {
    
    func getImagesFromDB() {
       
        database.observe(.value) { [self] snap, key  in
            if snap.childrenCount != 0 {
                itemscount = Int(snap.childrenCount)
                for i in 0...snap.childrenCount {
                    self.database.child("\(i)").observe(.value) { data,arg  in
                        if let dictionary = data.value as? [String: Any] {
                            print(dictionary["imageUrls"] as! String)
                            self.likes.append(dictionary["likes"] as! Int)
                            self.disLikes.append(dictionary["dislikes"] as! Int)
                            self.imgUrls.append(dictionary["imageUrls"] as! String)
                        }
                    }
                }
                self.imagesCollectionView.reloadData()
                
                
            }
        }
    }
    
    func willDeleteItem(){
        database.observe(.childRemoved) { [self] snap in
            print("bla bla")
            getImagesFromDB()
            imagesCollectionView.reloadData()
            dismiss(animated: false)
        }
    }
    
    @objc func didTapAddImg(){
        let vc = CreatePostVC()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
    
    @objc func refreshData(){
        imagesCollectionView.reloadData()
        refreshControl.endRefreshing()
    }
    
    
}



//MARK: collectionView delegate + datasource
extension FeedVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionsCell.id, for: indexPath) as! ImageCollectionsCell
        cell.initItems(imgUrl: imgUrls[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width-80)/2, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = FeedPreviewVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        vc.imageView.setImageFrom(imgUrls[indexPath.item])
        vc.likeCount = likes[indexPath.item]
        vc.dislikeCount = disLikes[indexPath.item]
        vc.index = indexPath.item
        present(vc, animated: true) {
            collectionView.reloadData()
        }
    }
}



//MARK: UI
extension FeedVC {
    
    
    fileprivate func setupUI(){
        imageCollectionConst()
        addImgBtnConst()
    }
    
    
    fileprivate func imageCollectionConst(){
        view.addSubview(imagesCollectionView)
        imagesCollectionView.top(backBtn.bottomAnchor, 10)
        imagesCollectionView.bottom(view.safeAreaLayoutGuide.bottomAnchor)
        imagesCollectionView.right(view.rightAnchor, -30)
        imagesCollectionView.left(view.leftAnchor, 30)
    }
    
    
    fileprivate func addImgBtnConst(){
        view.addSubview(addImgBtn)
        addImgBtn.top(view.safeAreaLayoutGuide.topAnchor, 20)
        addImgBtn.right(view.rightAnchor, -15)
        addImgBtn.height(60)
        addImgBtn.width(60)
    }
    
    
    
    
}
