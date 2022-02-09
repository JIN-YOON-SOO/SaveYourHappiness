//
//  MemoRegister.swift
//  save your happiness
//
//  Created by 진윤수 on 2022/01/06.
//
import UIKit
// import UIKit하면 자동으로 import Foundation해줌
// 데이터 베이스
import SQLite3

class PopUpViewController: UIViewController{
    let PopUpView : UIImageView = {
        let popUpView = UIImageView()
        popUpView.translatesAutoresizingMaskIntoConstraints = false
        popUpView.image = UIImage(named: "textarea.png")
        popUpView.contentMode = .scaleAspectFit
        //이미지뷰 터치
        //let touchGesture : UITapGestureRecognizer =  UITapGestureRecognizer(target: self, action: #selector(showTextView))
        //popUpView.addGestureRecognizer(touchGesture)
        //사용자의 액션에 반응하도록
        return popUpView
    }()
    
    let TextInputView: UITextView = {
        let textInputView = UITextView()
        textInputView.translatesAutoresizingMaskIntoConstraints = false
        textInputView.text =  "오늘의 행복을 말해주세요 💌"
        textInputView.textColor = .gray
        textInputView.font = UIFont(name: "KCCMurukmuruk", size: 15)
        textInputView.backgroundColor = .white
        textInputView.textAlignment = NSTextAlignment.center
        //textInputView.isEditable = false
        // UITextView의 초기 높이를 지정해주거나 스크롤을 못하게해야 텍스트뷰가 생성된다
        textInputView.isScrollEnabled = false
        return textInputView
    }()
    
    // 텍스트뷰 바깥쪽 화면 누르면 키보드 내려감
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          TextInputView.endEditing(true)
    }
    
    let MemoBackLabel : UILabel = {
        let memoBackLabel = UILabel()
        memoBackLabel.translatesAutoresizingMaskIntoConstraints = false
        memoBackLabel.textColor = .blue
        memoBackLabel.text = " ← 돌아가기"
        memoBackLabel.font = UIFont(name: "KCCMurukmuruk", size: 13)
        memoBackLabel.backgroundColor = UIColor.white.withAlphaComponent(0)
        return memoBackLabel
    }()
    
    let MemoBackButton : UIButton = {
        let memoBackButton = UIButton()
        memoBackButton.translatesAutoresizingMaskIntoConstraints = false
        memoBackButton.addTarget(self, action: #selector(memoBackButtonTouch), for: .touchUpInside)
        return memoBackButton
    }()
    
    @objc func memoBackButtonTouch(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    let LetterNumberLabel : UILabel = {
        let letterNumberLabel = UILabel()
        letterNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        letterNumberLabel.text = "0/150"
        letterNumberLabel.font = UIFont(name: "KCCMurukmuruk", size: 15)
        letterNumberLabel.textColor = .gray
        letterNumberLabel.textAlignment = .right
        return letterNumberLabel
    }()
    /*
    
    let CancelButton : UIButton = {
        let cancelButton = UIButton()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setImage(UIImage(named: "plusbutton.png"), for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonTouch), for: .touchUpInside)
        return cancelButton
    }()
    
    @objc func cancelButtonTouch(){
        // 취소 버튼 눌렀을 때 popUpView 삭제 - 기존 화면으로 돌아감
        dismiss(animated: true, completion: nil)
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(PopUpView)
        //view.addSubview(CancelButton)
        view.addSubview(TextInputView)
        view.addSubview(LetterNumberLabel)
        view.addSubview(MemoBackButton)
        view.addSubview(MemoBackLabel)
        // 팝업창 뒤 배경 반투명 만들기: 실수 값이 작을 수록 투명
        view.backgroundColor = .white
        TextInputView.delegate = self
      
        NSLayoutConstraint.activate([
            PopUpView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            //PopUpView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            PopUpView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            PopUpView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //CancelButton.centerXAnchor.constraint(equalTo: PopUpView.centerXAnchor),
            //CancelButton.centerYAnchor.constraint(equalTo: PopUpView.centerYAnchor, constant: 200),
            MemoBackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            MemoBackButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            MemoBackLabel.centerXAnchor.constraint(equalTo: MemoBackButton.centerXAnchor),
            MemoBackLabel.centerYAnchor.constraint(equalTo: MemoBackButton.centerYAnchor),
            TextInputView.centerXAnchor.constraint(equalTo: PopUpView.centerXAnchor),
            TextInputView.centerYAnchor.constraint(equalTo: PopUpView.centerYAnchor),
            TextInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            //TextInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            TextInputView.heightAnchor.constraint(lessThanOrEqualToConstant: 150),
            LetterNumberLabel.topAnchor.constraint(equalTo: PopUpView.bottomAnchor, constant: -15),
            LetterNumberLabel.trailingAnchor.constraint(equalTo: PopUpView.trailingAnchor, constant:-30)
        ])
        
    }
        
}
let placeholder = "오늘의 행복을 말해주세요 💌"

extension PopUpViewController: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // 엔터키 누르면 쓰기 종료
        /*
        if text == "\n"{
            textView.resignFirstResponder()
            return false
        }*/
        
        let currentText = textView.text ?? ""
        guard let stingRange = Range(range, in: currentText) else { return false}
        
        let changedText = currentText.replacingCharacters(in: stingRange, with: text)
        LetterNumberLabel.text = "\(changedText.count)/100"
        return (changedText.count < 100)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholder{
            textView.text = nil
        } else {
            textView.textColor = .gray
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty{
            textView.textColor = .gray
            textView.text = placeholder
        }else if textView.text != placeholder {
            // 옵셔널 바인딩 - if: 스코프 안에서만 사용 가능
            // guard: 스코프 안에서는 사용 불가 스코프 밖에서는 사용가
            guard let contentText = textView.text else{
                return
            }
            
            // 텍스트는 optinal 변수로 오는데 sqlite는 nil값 거부하는데... 써글놈 unwrap 하래ㅜㅜ
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy년 MM월 dd일-HH:mm:ss"
            
            dataBaseOpen()
            dateBaseInsert(_content: contentText, _date:dateFormatter.string(from: date))
            // 데이터베이스 구현
            // 연결 정보 - 구조체
            self.dismiss(animated: true, completion: nil)
            
    }
    
    func textViewDidChange(_ textView: UITextView) {
    
        }
    }
}
var db: OpaquePointer? //? optional: nil이 들어갈 수도 있음을 명시
//컴파일된 SQL을 담을 객체
let TABLE_NAME: String = "MyHappinessTable" // 테이블 이름
    
//Exception처리 1. try!: 예외 발생시 crash 발생 2. try?: 예외 발생시 nil 반환
//FileManager 파일 디렉토리의 생성, 이동, 읽기, 쓰기와 같은 동작 + 제어
// 데이터 관련 작업들 할때 반드시 데이터 베이스 파일 먼저 오픈해줘야힘
func dataBaseOpen(){
    let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("SaveUrHappiness.sqlite")
        
    //db 연결함수 - db 객체 생성
    if sqlite3_open(fileURL.path, &db) == SQLITE_OK{
    //print("table not exist")
    }
        
    let CREATE_QUERY_TEXT : String = "CREATE TABLE IF NOT EXISTS \(TABLE_NAME) (id INTEGER PRIMARY KEY AUTOINCREMENT, content TEXT, date TEXT)"
        
    //에러 발생시 알려줌
    if sqlite3_exec(db, CREATE_QUERY_TEXT, nil, nil, nil) != SQLITE_OK{
        let errMsg = String(cString: sqlite3_errmsg(db))
        print("db table create error: \(errMsg)")
        return
    }
        
}
// 데이터 삽입
func dateBaseInsert(_content:String, _date:String){
        
    var stmt : OpaquePointer?
        
    let INSERT_QUERY_TEXT : String =  "INSERT INTO \(TABLE_NAME) (content, date) Values (?,?)"
        
        // 컴파일 된 sql 구문 객체가 생성된다
        if sqlite3_prepare(db, INSERT_QUERY_TEXT, -1, &stmt, nil) != SQLITE_OK{
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: v1 \(errMsg)")
            return
        }
        
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        if sqlite3_bind_text(stmt, 1, _content, -1, SQLITE_TRANSIENT) != SQLITE_OK{
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error binding name: \(errMsg)")
            return
        }
        
        if sqlite3_bind_text(stmt, 2, _date, -1, SQLITE_TRANSIENT) != SQLITE_OK{
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error binding name: \(errMsg)")
            return
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE{
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("insert fail :: \(errMsg)")
            return
        }
    
        UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "mycoin") + 5, forKey: "mycoin")
    }
        
    //화면이동
// 구조체
struct MemoData {
    var Id : Int
    var Content : String
    var Date : String
}
// 데이터 검색
func dataBaseSearch() -> [MemoData]{
    var stmt : OpaquePointer?
    let SELECT_QUERY = "SELECT * FROM \(TABLE_NAME)"
    // 구조체 배열 선언
    var memoDataArray : [MemoData] = []
        
    if sqlite3_prepare(db, SELECT_QUERY, -1, &stmt, nil) != SQLITE_OK{
        let errMsg = String(cString: sqlite3_errmsg(db)!)
        print("error preparing insert: v1\(errMsg)")
    }
        
    while(sqlite3_step(stmt) == SQLITE_ROW){
        let id = sqlite3_column_int(stmt, 0)
        // content가 제대로 안들어옴 왜 nil? => 해결~~
        let content = String(cString:sqlite3_column_text(stmt, 1))
        // data는 잘 들어오네유.. 근데 왜 date가 content에 가있는지.. => 해결~~
        let date = String(cString:sqlite3_column_text(stmt, 2))
            
        //print("id \(id), content \(content), date \(date)")
        
        let memoData : MemoData = MemoData(Id: Int(id), Content: String(content), Date: String(date))
        memoDataArray.append(memoData)
    }
    
    return memoDataArray
}

// 데이터 수정
func update(_id:String, _content: String, _date: String){
    let UPDATE_QUERY = "UPDATE\(TABLE_NAME) Set content='\(_content)', date='\(_date)' WHERE id == \(_id)"
    var stmt:OpaquePointer?
    
    print(UPDATE_QUERY)
    
    if sqlite3_prepare(db, UPDATE_QUERY, -1, &stmt, nil) != SQLITE_OK{
        let errMsg = String(cString:sqlite3_errmsg(db)!)
        print("error preparing update: v1\(errMsg)")
        return
    }
    if sqlite3_step(stmt) != SQLITE_DONE{
        let errMsg = String(cString: sqlite3_errmsg(db)!)
        print("update fail :: \(errMsg)")
        return
    }
    sqlite3_finalize(stmt)
    print("update success")
}

// 데이터 삭제
func deleteData(_id: Int){
    let DELETE_QUERY = "DELETE FROM \(TABLE_NAME) WHERE id = \(_id)"
    var stmt: OpaquePointer?
    
    print(DELETE_QUERY)
    
    if sqlite3_prepare_v2(db, DELETE_QUERY, -1, &stmt, nil) != SQLITE_OK{
        let errMsg = String(cString: sqlite3_errmsg(db)!)
        print("error preparing delete: v1\(errMsg)")
        return
    }
    
    if sqlite3_step(stmt) != SQLITE_DONE{
        let errMsg = String(cString: sqlite3_errmsg(db)!)
        print("delete fail :: \(errMsg)")
        return
    }
    sqlite3_finalize(stmt)
}
