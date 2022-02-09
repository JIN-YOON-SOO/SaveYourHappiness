//
//  FirstLanch.swift
//  save your happiness
//
//  Created by 진윤수 on 2022/01/18.
//

import Foundation
public class FirstLanch {
    //static 오버라이딩 금지!
    static func isFirstTime() -> Bool {
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "isFirstTime") == nil{
            defaults.set("No", forKey: "isFirstTime")
            return true
        } else {
            return false
        }
    }
}
