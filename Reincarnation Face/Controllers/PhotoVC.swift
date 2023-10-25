//
//  PhotoVC.swift
//  Reincarnation Face
//
//  Created by Nurillo Domlajonov on 01/11/23.
//

import UIKit
var savedImage: UIImage?

class PhotoVC: BaseVC, ImageSelectionDelegate {
    
    func didSelectImage(_ image: UIImage) {
        patternImgView.image = image
    }
    
    
    lazy var cameraBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "cameraBtn"), for: .normal)
        btn.addTarget(self, action: #selector(showPhotoLibraryOrCamera), for: .touchUpInside)
        btn.imageView?.contentMode = .scaleAspectFit
        
        return btn
    }()
    
    lazy var patternImgView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "example")
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        
        return img
    }()
    
    lazy var saveBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "saveBtn"), for: .normal)
        btn.addTarget(self, action: #selector(saveImage), for: .touchUpInside)
        btn.imageView?.contentMode = .scaleAspectFit
        
        return btn
    }()
    
    lazy var photoBackBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "photoBackBtn"), for: .normal)
        btn.addTarget(self, action: #selector(didTapBackBtn), for: .touchUpInside)
        btn.imageView?.contentMode = .scaleAspectFit
        
        return btn
    }()
    
    lazy var anotherBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "anotherBtn"), for: .normal)
        btn.addTarget(self, action: #selector(didTapBackBtn), for: .touchUpInside)
        btn.imageView?.contentMode = .scaleAspectFit
        
        return btn
    }()
    
    let imagePicker = UIImagePickerController()
    let userdefaults = UserDefaultsManager.shared
    let db = DatabaseManager.shared
}



//MARK: acitons
extension PhotoVC {
    
    @objc func showPhotoLibraryOrCamera(){
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
    
    @objc func saveImage(){
        db.addImg(imgData: patternImgView.image!, likes: 0, dislikes: 0)
        var cc = userdefaults.getDataCount()
        cc+=1
        userdefaults.setDataCount(count: cc)
        showSavedAlert()
    }
    
    func initImages(img: String){
        patternImgView.image = UIImage(named: img)
    }
    
    func showSavedAlert(){
        let alert = UIAlertController(title: "Saved", message: "Your photo has saved successfully", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { aa in
            self.dismiss(animated: true)
        }))
        present(alert, animated: true)
    }
    
  
}



//MARK: life cycle
extension PhotoVC{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}



extension PhotoVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
            return
        }
        
        guard let imageData = image.pngData() else {
            return
        }
        
        let vc = DrawVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        vc.imageView.image = image
        vc.maskImageView.image = patternImgView.image
        vc.delegate = self
        present(vc, animated: true)
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true )
    }
    
    
}


//MARK: UI
extension PhotoVC {
    
    fileprivate func setupUI(){
        bgImgView.image = UIImage(named: "beginBG")
        cameraBtnConst()
        patternImgViewConst()
        saveBtnConst()
        photoBackBtnConst()
        anotherBtnConst()
    }
    
    
    fileprivate func cameraBtnConst(){
        view.addSubview(cameraBtn)
        cameraBtn.centerX(view.centerXAnchor)
        cameraBtn.top(backBtn.bottomAnchor, 10)
        cameraBtn.height(70)
        cameraBtn.width(70)
    }
    
    
    fileprivate func patternImgViewConst(){
        view.addSubview(patternImgView)
        patternImgView.top(cameraBtn.bottomAnchor, 20)
        patternImgView.left(view.leftAnchor, 20)
        patternImgView.right(view.rightAnchor, -20)
        patternImgView.bottom(view.centerYAnchor, 100)
    }
    
    fileprivate func saveBtnConst(){
        view.addSubview(saveBtn)
        saveBtn.top(patternImgView.bottomAnchor, 20)
        saveBtn.left(patternImgView.leftAnchor)
        saveBtn.right(view.centerXAnchor, -10)
        saveBtn.height(80)
    }
    
    
    fileprivate func photoBackBtnConst(){
        view.addSubview(photoBackBtn)
        photoBackBtn.top(saveBtn.topAnchor)
        photoBackBtn.right(patternImgView.rightAnchor)
        photoBackBtn.left(view.centerXAnchor, 10)
        photoBackBtn.height(80)
    }
    
    
    fileprivate func anotherBtnConst(){
        view.addSubview(anotherBtn)
        anotherBtn.top(saveBtn.bottomAnchor, 20)
        anotherBtn.right(photoBackBtn.rightAnchor)
        anotherBtn.left(saveBtn.leftAnchor)
        anotherBtn.height(80)
    }
    
}
