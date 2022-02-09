//
//  Memolist.swift
//  save your happiness
//
//  Created by 진윤수 on 2022/01/08.
//

import UIKit

let todayDate = GetDate()
let formatter = DateFormatter()

class MemoListViewController : UIViewController{
    
    // 상단 네비게이션뷰
    let NavigationView: UIView = {
        let navigationView = UIView()
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        navigationView.backgroundColor = .black
        // 투명도 조절
        navigationView.alpha = 0.5
        return navigationView
    }()
    
    let NavigationDateView: UILabel = {
        let navigationDateView = UILabel()
        navigationDateView.translatesAutoresizingMaskIntoConstraints = false
        navigationDateView.font = UIFont(name:"KCCMurukmuruk", size: 15)
        navigationDateView.textColor = .black
        navigationDateView.backgroundColor = UIColor.white.withAlphaComponent(0)
        navigationDateView.text = todayDate.getNowTime()
        // 사용자 터치에 반응하도록 구현 => viewDidLoad에서 해줘야함
        /*let touchGesture: UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MemoListViewController.showCalendar))
        navigationDateView.isUserInteractionEnabled = true
        navigationDateView.addGestureRecognizer(touchGesture)*/
        return navigationDateView
    }()
    
    @objc func showCalendar(_sender:UITapGestureRecognizer){
        let datePickerViewContoller = DatePickerViewController()
        datePickerViewContoller.modalPresentationStyle = .overCurrentContext
        present(datePickerViewContoller, animated: true, completion: nil)
    }
    //데이터 피커로 구현 + 버튼으로 날짜 이동 구현
    let RightButton: UIButton = {
       let rightButton = UIButton()
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.setImage(UIImage(named: "r_button.png"), for: .normal)
        rightButton.addTarget(self, action: #selector(rightButtonClick), for: .touchUpInside)
        return rightButton
    }()
    
    @objc func rightButtonClick(_sender:UIButton) {
        todayDate.markdate = Date(timeInterval: 24*60*60, since: todayDate.markdate)
        formatter.dateFormat = "yyyy년 MM월 dd일"
        let futureDay = formatter.string(from:todayDate.markdate)
        NavigationDateView.text = futureDay
        MemoListView.reloadData()
    }
    
    let LeftButton: UIButton = {
        let leftButtonTouch = UIButton()
        leftButtonTouch.translatesAutoresizingMaskIntoConstraints = false
        leftButtonTouch.setImage(UIImage(named: "l_button.png"), for: .normal)
        leftButtonTouch.addTarget(self, action: #selector(leftButtonClick), for: .touchUpInside)
        return leftButtonTouch
    }()
    
    @objc func leftButtonClick(_sender:UIButton){
        todayDate.markdate = Date(timeInterval: -24*60*60, since: todayDate.markdate)
        formatter.dateFormat = "yyyy년 MM월 dd일"
        let pastDay = formatter.string(from:todayDate.markdate)
        NavigationDateView.text = pastDay
        MemoListView.reloadData()
    }
    
    
    let MemoBackgroundView : UIImageView = {
        let memoBackgroundView = UIImageView()
        memoBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        memoBackgroundView.image = UIImage(named: ".png")
        return memoBackgroundView
    }()
    
    let MemoListView : UITableView = {
        let memoListView = UITableView()
        memoListView.translatesAutoresizingMaskIntoConstraints = false
        // 빈 행 라인 숨기기
        memoListView.tableFooterView = UIView()
        memoListView.rowHeight = UIScreen.main.bounds.height / 4
        // 줄 왼쪽 마진 없앰
        memoListView.separatorInset.left = 0
        memoListView.showsVerticalScrollIndicator = false
        // 셀 크기 동일하게 맞춰주기 - 아니 근데 그냥 위에 상단 배터리 영역으로 올라가는데..?
        //memoListView.contentInsetAdjustmentBehavior = .never
        return memoListView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(NavigationView)
        view.addSubview(MemoBackgroundView)
        view.addSubview(MemoListView)
        view.addSubview(RightButton)
        view.addSubview(LeftButton)
        view.addSubview(NavigationDateView)
        view.backgroundColor = UIColor.white
        view.backgroundColor = UIColor(displayP3Red: 218/255, green: 218/255, blue: 218/255, alpha: 1.0)
        MemoListView.delegate = self
        MemoListView.dataSource = self
        MemoListView.register(UITableViewCell.self, forCellReuseIdentifier: "MomoListViewCell")
        //데이터 베이스 오픈
        dataBaseOpen()
        //let touchGesture: UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MemoListViewController.showCalendar))
        //NavigationDateView.isUserInteractionEnabled = true
        //NavigationDateView.addGestureRecognizer(touchGesture)
        //날짜
        NSLayoutConstraint.activate([
            NavigationView.bottomAnchor.constraint(equalTo: MemoListView.topAnchor),
            NavigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            NavigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            NavigationDateView.bottomAnchor.constraint(equalTo: NavigationView.bottomAnchor, constant: -20),
            NavigationDateView.centerXAnchor.constraint(equalTo: NavigationView.centerXAnchor),
            RightButton.bottomAnchor.constraint(equalTo: NavigationView.bottomAnchor, constant: -15),
            RightButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            LeftButton.bottomAnchor.constraint(equalTo: NavigationView.bottomAnchor, constant: -15),
            LeftButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            MemoBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            MemoBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            MemoBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            MemoBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            MemoListView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            MemoListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            MemoListView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            MemoListView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}
// 화면에 띄워보자 영차영차
extension MemoListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 데이터 개수랑 맞춰줘야지..
        let memoDataCount  = getContentArray()
        return memoDataCount.count
    }
}

func getContentArray () -> [String]{
    let memodata = dataBaseSearch()
    var memoContent : [String] = []
    
    formatter.dateFormat = "yyyy년 MM월 dd일"
    //날짜에 맞는 것만 리스트에 보이기
    if memodata.count != 0{
        for i in 0...memodata.count-1{
            if memodata[i].Date.split(separator: "-")[0] == formatter.string(from:todayDate.markdate){
                memoContent.append(memodata[i].Content)
            }
        }
    }
    return memoContent
}

func getIdArray() -> [Int]{
    let memodata = dataBaseSearch()
    var memoId : [Int] = []
    
    formatter.dateFormat = "yyyy년 MM월 dd일"
    //날짜에 맞는 것만 리스트에 보이기
    for i in 0...memodata.count-1{
        if memodata[i].Date.split(separator: "-")[0] == formatter.string(from:todayDate.markdate){
            memoId.append(memodata[i].Id)
        }
    }
    return memoId
}

extension MemoListViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 큐에 넣어서 사용할꺼야..!
        //let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "MomoListViewCell")!as UITableViewCell
        let cell: UITableViewCell = UITableViewCell()
        var memoContent = getContentArray()
        if memoContent.isEmpty {
            memoContent.removeAll()
            cell.textLabel?.text = " "
        }else{
            cell.textLabel?.text = memoContent[indexPath.row]
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.font = UIFont(name: "KCCMurukmuruk", size: 15)
            //cell.textLabel?.adjustsFontSizeToFitWidth = true
        }
        return cell
    }
    
    // 스와이프해서 삭제 - 에러 고치자
    // 문제 리스트에 있는 데이터가 들어있는 배열이 다른 함수에서 정의되어있기 때문인데..
    // 근데.. 저게 업데이트 계속 하려고 저기다가 놓은건데..하..
    func tableView(_tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        var memoContent = getContentArray()
        let memoId = getIdArray()
        
        if editingStyle == .delete{
            tableView.beginUpdates()
            memoContent.remove(at: indexPath.row)
            deleteData(_id: memoId[indexPath.row])
            // 밑에 코드 실행하기 전에 반드시 연동되어있는 데이터를 함께 지워줘야함
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
        
    }
    /*
    // 셀 선택해서 수정하는 기능 만드려구요 ㅋ 삭제(편집)기능 넣어서 선택이 안된다..
    func tableView(_tableView: UITableView, didSelectRowAt indexPath: IndexPath){

        let updateContentViewController = UpdateContentViewController()
        updateContentViewController.modalPresentationStyle = .overCurrentContext
        present(updateContentViewController, animated: true, completion: nil)
        
    }*/
}

