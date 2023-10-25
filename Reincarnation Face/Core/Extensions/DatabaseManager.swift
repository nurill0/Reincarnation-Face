//
//  DatabaseManager.swift
//  Plant-disease
//
//  Created by Nurillo Domlajonov on 08/11/22.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth


class DatabaseManager{
    static let shared = DatabaseManager()
    let database = Database.database().reference(fromURL: "https://reincarnation-face-default-rtdb.firebaseio.com")
    private let storage = Storage.storage().reference()
    private let userdefaultsManager = UserDefaultsManager.shared
    
    
    func addImg(imgData: UIImage, likes: Int, dislikes: Int){
        let id = Int.random(in: 10...1000)
        var ID = 0
        storage.child(UIDevice.current.identifierForVendor!.uuidString).child("\(id).png").putData(imgData.pngData()!,
                                                                                                         metadata: nil) { _, error in
            guard error == nil else {
                print(error?.localizedDescription)
                return}
            
            self.storage.child(UIDevice.current.identifierForVendor!.uuidString).child("\(id).png").downloadURL { [self] urL, err in
                guard let url = urL, err == nil else {
                    print("url error")
                    return
                }
                
                let urlString = url.absoluteString
                            
                let object: [String: Any] = [
                    "device": UIDevice.current.identifierForVendor!.uuidString,
                    "imageUrls" : urlString,
                    "likes" :  likes,
                    "dislikes" :  dislikes,
                ]
                self.database.observe(.value) { snap, key in
                    ID = Int(snap.childrenCount)
                }
                self.database.ref.child("\(userdefaultsManager.getDataCount())").setValue(object)
            }
        }
    }
    
    func addLike(likes: Int, count: Int) {
        self.database.ref.child("\(count+1)").child("likes").setValue(likes)
    }
    
    func addDislike(dislikes: Int, count: Int) {
        self.database.ref.child("\(count+1)").child("dislikes").setValue(dislikes)
    }
}
