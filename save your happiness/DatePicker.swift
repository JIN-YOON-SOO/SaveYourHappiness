//
//  DatePickerView.swift
//  save your happiness
//
//  Created by 진윤수 on 2022/01/10.
//

import UIKit
class DatePickerViewController: UIViewController{
    // 데이트 피커는 초기 높이 값을 가지고 있어서 위치만 설정해주면 된다
    let DatePickerView : UIDatePicker = {
        let datePickerView = UIDatePicker()
        datePickerView.translatesAutoresizingMaskIntoConstraints = false
        datePickerView.datePickerMode = .date
        datePickerView.preferredDatePickerStyle = .inline
        datePickerView.setValue(UIColor.black, forKeyPath: "textColor")
        //datePickerView.setValue(true, forKeyPath: "highlightsToday")
        // 국가 설정 안하면 - 아이폰 기본 설정 - 응 영어야~
        datePickerView.locale = Locale(identifier: "ko-KR")
        datePickerView.timeZone = .autoupdatingCurrent
        // 처음에 보이는 날짜
        datePickerView.date = Date()
        datePickerView.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
        return datePickerView
    }()
    
    @objc func handleDatePicker(_sender: UIDatePicker){
        print(_sender.date)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(DatePickerView)
        view.backgroundColor = UIColor(displayP3Red: 218/255, green: 218/255, blue: 218/255, alpha: 1.0)
        
        NSLayoutConstraint.activate([
            DatePickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            DatePickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            DatePickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            DatePickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
    }
}
