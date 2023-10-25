//
//  CreatePostVC.swift
//  Reincarnation Face
//
//  Created by Nurillo Domlajonov on 26/10/23.
//

import UIKit

class CreatePostVC: BaseVC, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
    lazy var imageFrameView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "imgFrame")
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        
        return img
    }()
    
    lazy var imageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "")?.withRenderingMode(.alwaysOriginal).withTintColor(.white.withAlphaComponent(0.8))
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true

        return img
    }()
    
    lazy var postBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "postBtn"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(didTapPostBtn), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var addImgBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "addPhotoLib"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(didTapCamera), for: .touchUpInside)
        btn.isEnabled = true
        btn.isUserInteractionEnabled = true
        
        return btn
    }()
  
    let db = DatabaseManager.shared
    let userdefaults = UserDefaultsManager.shared
}



//MARK: life cycle
extension CreatePostVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}



//MARK: actions
extension CreatePostVC {
    
    @objc func didTapPostBtn(){
        if imageView.image != UIImage(named: "") {
            db.addImg(imgData: imageView.image!, likes: 0, dislikes: 0)
            var cc = userdefaults.getDataCount()
            cc+=1
            userdefaults.setDataCount(count: cc)
            showSavedAlert()
        }
            
    }
    
    @objc func didTapCamera(){
        let alert = UIAlertController(title: "Choose Photos", message: "Please choose for select picture", preferredStyle: .alert)
        if let image = UIImage(systemName: "photo.on.rectangle.angled") {
            let action = UIAlertAction(title: "     Photo Library", style: .default) { [self] _ in
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.allowsEditing = true
                picker.delegate = self
                self.present(picker, animated: true)
            }
            action.setValue(image.withRenderingMode(.alwaysOriginal), forKey: "image") // Set image to the action
            alert.addAction(action)
        }
        if let image = UIImage(systemName: "camera.fill") {
            let action = UIAlertAction(title: "     Camera", style: .default) { [self] _ in
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.allowsEditing = true
                picker.delegate = self
                self.present(picker, animated: true)
            }
            action.setValue(image.withRenderingMode(.alwaysOriginal), forKey: "image")  // Set image to the action
            alert.addAction(action)
        }
        alert.addAction(UIAlertAction(title: "     Cancel", style: .cancel, handler: { alert in
            
        }))
        present(alert, animated: true)
    }
    
    func showSavedAlert(){
        let alert = UIAlertController(title: "Saved", message: "Your photo has saved successfully", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { aa in
            self.presentingViewController?.presentingViewController?.dismiss(animated: false)
        }))
        present(alert, animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
            return
        }
        
        guard let imageData = image.pngData() else {
            return
        }
        
        imageView.image = image
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true )
    }
    
}



//MARK: UI
extension CreatePostVC {
    
    
    fileprivate func setupUI(){
        frameImgConst()
        imageViewConst()
        postBtnConst()
        addImgConst()
    }
    
    
    fileprivate func frameImgConst(){
        view.addSubview(imageFrameView)
        imageFrameView.top(backBtn.bottomAnchor, 30)
        imageFrameView.right(view.rightAnchor, -20)
        imageFrameView.left(view.leftAnchor, 20)
        imageFrameView.bottom(view.centerYAnchor, 200)
    }
    
    
    fileprivate func imageViewConst(){
        imageFrameView.addSubview(imageView)
        imageView.top(imageFrameView.topAnchor, 80)
        imageView.bottom(imageFrameView.bottomAnchor, -80)
        imageView.right(imageFrameView.rightAnchor, -30)
        imageView.left(imageFrameView.leftAnchor, 30)
    }
    
    
    fileprivate func postBtnConst(){
        view.addSubview(postBtn)
        postBtn.top(imageFrameView.bottomAnchor, 30)
        postBtn.right(view.rightAnchor, -30)
        postBtn.left(view.leftAnchor, 30)
        postBtn.height(90)
    }
    
    
    fileprivate func addImgConst(){
        imageFrameView.addSubview(addImgBtn)
        addImgBtn.bottom(postBtn.topAnchor, -10)
        addImgBtn.centerX(imageFrameView.centerXAnchor)
        addImgBtn.height(50)
        addImgBtn.width(70)
    }
    
}
