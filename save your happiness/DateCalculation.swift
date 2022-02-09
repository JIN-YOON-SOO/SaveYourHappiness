//
//  DateCalculation.swift
//  save your happiness
//
//  Created by 진윤수 on 2022/01/10.
//
import UIKit

class GetDate{
    // Model 프로퍼티의 값을 변경해주려고할때 쓰는 것[프로퍼티 옵저버] => didSet, willSet
    var markdate : Date = Date(){
        willSet(newValue){
        }
        didSet(oldValue) {
        }
    }
    
    func getNowTime() -> String{
        
        let formatterYear = DateFormatter()
        formatterYear.dateFormat = "yyyy"
        let currentYear = formatterYear.string(from:Date())

        let formatterMonth = DateFormatter()
        formatterMonth.dateFormat = "MM"
        let currentMonth = formatterMonth.string(from: Date())
        
        let formatterDay = DateFormatter()
        formatterDay.dateFormat = "dd"
        let currentDay = formatterDay.string(from: Date())
        
        let today = currentYear + "년 " + currentMonth + "월 " + currentDay + "일 "
        return today
        }
}

