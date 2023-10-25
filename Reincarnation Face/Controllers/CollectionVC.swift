//
//  CollectionVC.swift
//  Reincarnation Face
//
//  Created by Nurillo Domlajonov on 26/10/23.
//

import UIKit
import FirebaseDatabaseInternal

class CollectionVC: BaseVC {
    
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
    
    let uDManager = UserDefaultsManager.shared
    let database = Database.database().reference(fromURL:  "https://reincarnation-face-default-rtdb.firebaseio.com")
    
    
    var imgUrls: [String] = [] {
        didSet{
            imagesCollectionView.reloadData()
        }
    }
    
    var refreshControl = UIRefreshControl()
    
    
    
}



//MARK: life cycle
extension CollectionVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getImagesFromDB()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        imagesCollectionView.refreshControl = refreshControl
        
        
    }
    
}



//MARK: actions
extension CollectionVC {
    
    func getImagesFromDB() {
        database.observe(.value) { snap, key  in
            for i in 0...snap.childrenCount {
                self.database.child("\(i)").observe(.value) { data in
                    if let dictionary = data.value as? [String: Any] {
                        print(dictionary["imageUrls"] as! String)
                        self.imgUrls.append(dictionary["imageUrls"] as! String)
                        self.imagesCollectionView.reloadData()
                    }
                }
            }
        }
    }
    
    @objc func refreshData(){
        imagesCollectionView.reloadData()
        refreshControl.endRefreshing()
    }
    
}



//MARK: collectionview delegate + data source
extension CollectionVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        let vc = CollectionPreviewVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.imageView.setImageFrom(imgUrls[indexPath.item])
        vc.index = indexPath.item
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
}



//MARK: UI
extension CollectionVC {
    
    
    fileprivate func setupUI(){
        imageCollectionConst()
    }
    
    
    fileprivate func imageCollectionConst(){
        view.addSubview(imagesCollectionView)
        imagesCollectionView.top(backBtn.bottomAnchor, 10)
        imagesCollectionView.bottom(view.safeAreaLayoutGuide.bottomAnchor)
        imagesCollectionView.right(view.rightAnchor, -30)
        imagesCollectionView.left(view.leftAnchor, 30)
    }
}
