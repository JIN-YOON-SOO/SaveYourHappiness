//
//  StoreItem.swift
//  save your happiness
//
//  Created by 진윤수 on 2022/01/13.
//

import UIKit
    
// class는 initializer 필요
struct Item: Codable {
    var name: String
    var imageName: String
    var story: String
    var price: Int
    var state : Bool
    var category: String
    
    /*
    init(name: String, imageName: String, story: String, price: Int, state : Int, catecory: String){
        self.name = name
        self.imageName = imageName
        self.story = story
        self.price = price
        self.state = state
        self.catecory = catecory
    }*/
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case imageName = "imageName"
        case story = "story"
        case price = "price"
        case state = "state"
        case category = "category"
    }
}
/*
class ItemArray{
    var totalItemArray : [Item] = []
    var itemName : [String] = []
    var itemStory : [String] = []
    var itemPrice : [Int] = []
    var itemImageName : [String] = []
    var itemCategory : [String] = []
    var itemImgName : [UIImage?] = []
    var clickRow : Int = 0
    
    //mutating 값 타입의 속성 변경해주려면 붙여야함 -struct
    func loadJsonFile(){
        guard let path = Bundle.main.path(forResource: "ItemList", ofType: "json") else{
            return
        }
        guard let jsonString = try? String(contentsOfFile: path) else{
            return
        }
        let decoder = JSONDecoder()
        let data = jsonString.data(using: .utf8)
        if let data = data,
         let item = try? decoder.decode([Item].self, from: data){
            totalItemArray.append(contentsOf: item)
         }
    }
    
    func getItemName() {
        for i in 0...totalItemArray.count-1{
            itemName.append(totalItemArray[i].name)
            itemStory.append(totalItemArray[i].story)
            itemPrice.append(totalItemArray[i].price)
            itemImageName.append(totalItemArray[i].imageName)
            itemCategory.append(totalItemArray[i].category)
        }
        
        for i in 0...itemImageName.count-1{
            itemImgName.append(UIImage(named: itemImageName[i])!)
        }
    }
    
}*/
