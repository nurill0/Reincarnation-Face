//
//  UserDefaultsManager.swift
//
//  Created by Nurillo Domlajonov on 11/08/23.
//

import UIKit

class UserDefaultsManager{
    
    static let shared = UserDefaultsManager()
    let defaults = UserDefaults.standard
    
    func saveTemperoraryIma(img: UIImage) {
        UserDefaults.standard.set(img, forKey: "tempImg")
    }
    
    func setDataCount(count: Int){
        UserDefaults.standard.set(count, forKey: "dataCount")
    }
    
    func setIdForDB(count: Int){
        UserDefaults.standard.set(count, forKey: "idForDB")
    }
    
    
    func getTempImage()->UIImage {
        return UserDefaults.standard.value(forKey: "tempImg") as! UIImage
    }
    
    func getDataCount()->Int {
        return UserDefaults.standard.value(forKey: "dataCount") as! Int
    }
   
    func getIdForDB()->Int {
        return UserDefaults.standard.value(forKey: "idForDB") as! Int
    }
    
    func saveNickName(nickName: String){
        defaults.setValue(nickName, forKey: "nickName")
    }
    
    func getNickName()->String {
        return defaults.object(forKey: "nickName") as? String ?? "unknown"
    }
  
}
