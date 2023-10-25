//
//  Model.swift
//  Reincarnation Face
//
//  Created by Nurillo Domlajonov on 25/10/23.
//

import Foundation

let desc = """
"This app is designed for you to have fun with yourself, your friends and share positivity with the rest of the app users.

The app will use the camera to insert your photo into the photo collages that we have prepared for you and will update.

You can also rate the photo collages of other users who post them to a shared feed, and you can also share collages from your own collection.

All data is used exclusively within the app and is not shared with third parties.
We wish you to have fun with our app!"

"""


struct PatternData {
    
    let titles: [String] = ["animals", "pin up", "rock", "funny", "kids", "scary"]
    
    let animals: [String] = ["a1", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16", "a17", "a18", "a19", "a20"]
    
    let pinup: [String] = ["p1", "p2", "p3", "p4", "p5", "p6"]
    
    let rock: [String] = ["r1", "r2", "r3", "r4", "r5"]
    
    let funny: [String] = ["f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8", "f9"]
    
    let kids: [String] = ["k1", "k2", "k3", "k4", "k5", "k6", "k7", "k8", "k9", "k10"]
    
    let scary: [String] = ["s1", "s2", "s3", "s4", "s5", "s6"]

    func getTitle(index: Int)->String{
        return titles[index]
    }
    
    func getAnimals(index: Int)-> String{
        return animals[index]
    }

    func getPinup(index: Int)-> String{
        return pinup[index]
    }
    
    func getRock(index: Int)-> String{
        return rock[index]
    }
    
    func getFunny(index: Int)-> String{
        return funny[index]
    }
    
    func getKids(index: Int)-> String{
        return kids[index]
    }
    
    func getScary(index: Int)-> String{
        return scary[index]
    }
    
    func getAnimalsSize()->Int {
        return animals.count
    }
    
    func getPinupSize()->Int {
        return pinup.count
    }
    
    func getRockSize()->Int {
        return rock.count
    }
    
    func getFunnySize()->Int {
        return funny.count
    }
    
    func getKidsSize()->Int {
        return kids.count
    }
    
    func getScarySize()->Int {
        return scary.count
    }
    
    
}
