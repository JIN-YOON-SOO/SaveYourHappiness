//
//  ChangeSetting.swift
//  save your happiness
//
//  Created by 진윤수 on 2022/02/12.
//

import UIKit

class ChangeSettingController: UIViewController {
    
    let sections = ["기본 설정", "테마 변경"]
    let settingList_section0 = ["잠금 설정", "알림 설정"]
    let settingImage_section0 = [UIImage(named: "lock.png"), UIImage(named: "bell.png")]
    let settingList_section1 = ["폰트 변경", "배경색 변경"]
    let settingImage_section1 = [UIImage(named: "text.png"), UIImage(named: "backgroundcolor.png")]
    var clickRow : Int = 0
    
    let ChangeSettingView : UIView = {
        let changeSettingView = UIView()
        changeSettingView.translatesAutoresizingMaskIntoConstraints = false
        changeSettingView.backgroundColor = .white
        return changeSettingView
    }()
    

    let ChangeTableView : UITableView = {
        let changeTableView = UITableView()
        changeTableView.translatesAutoresizingMaskIntoConstraints = false
        changeTableView.separatorStyle = .none
        return changeTableView
    }()
    
    let BackButton : UIButton = {
       let backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        backButton.backgroundColor = .blue
        backButton.addTarget(self, action: #selector(backButtonTouch), for: .touchUpInside)
        return backButton
    }()
    
    @objc func backButtonTouch(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(ChangeSettingView)
        view.addSubview(ChangeTableView)
        view.addSubview(BackButton)
        
        ChangeTableView.delegate = self
        ChangeTableView.dataSource = self
        ChangeTableView.register(ChangeSettingTableViewCell.self, forCellReuseIdentifier: "ChangeSettingTableViewCell")
        
        NSLayoutConstraint.activate([
            ChangeSettingView.topAnchor.constraint(equalTo: view.topAnchor),
            ChangeSettingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ChangeSettingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ChangeSettingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            BackButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            BackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            ChangeTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            ChangeTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            ChangeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            ChangeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
    }
}
extension ChangeSettingController : UITableViewDelegate, UITableViewDataSource {
    func alarmButtonTouch(){
        let alarmViewController = AlarmViewController()
        alarmViewController.modalPresentationStyle = .fullScreen
        alarmViewController.modalTransitionStyle = .coverVertical
        present(alarmViewController, animated: true, completion: nil)
    }
    
    func fontButtonTouch(){
        let fontViewController = FontViewController()
        fontViewController.modalPresentationStyle = .fullScreen
        fontViewController.modalTransitionStyle = .coverVertical
        present(fontViewController, animated: true, completion: nil)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            clickRow = indexPath.row
            if clickRow == 0 {
            } else {
                alarmButtonTouch()
            }
        } else {
            clickRow = indexPath.row
            if clickRow == 0 {
                fontButtonTouch()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        
        let View : UIView = {
            let view = UIView(frame: .zero)
            view.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
            return view
        }()
        
        header.textLabel?.textColor = .darkGray
        header.backgroundView = View
        header.layer.cornerRadius = 10
        header.layer.masksToBounds = true

    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return settingList_section0.count
        } else {
            return settingList_section1.count
        }
            
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ChangeSettingTableViewCell()
        //cell.layer.cornerRadius = 20
        //cell.layer.masksToBounds = true
        cell.selectionStyle = .none
        cell.viewController = self
        
        if indexPath.section == 0{
            if indexPath.row == 0 {
                cell.addSubview(cell.LockSwitchButton)
                cell.LockSwitchButton.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -10).isActive = true
                cell.LockSwitchButton.topAnchor.constraint(equalTo: cell.topAnchor, constant: 10).isActive = true
                cell.LockSwitchButton.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
            }
            cell.ButtonImage.image = settingImage_section0[indexPath.row]
            cell.ButtonLabel.text = settingList_section0[indexPath.row]
        } else {
            cell.ButtonImage.image = settingImage_section1[indexPath.row]
            cell.ButtonLabel.text = settingList_section1[indexPath.row]
        }
        
        return cell
    }
}

class ChangeSettingTableViewCell : UITableViewCell {
    
    weak var viewController: UIViewController?
    
    func lockButtonOn(){
        let lockViewController = LockViewController()
        lockViewController.modalPresentationStyle = .fullScreen
        lockViewController.modalTransitionStyle = .coverVertical
        viewController?.present(lockViewController, animated: true, completion: nil)
    }
    
    func lockButtonOff(){
        // 비밀번호 초기화 & 잠금 아닌 상태로 고정
        UserDefaults.standard.set(false, forKey: "lockState")
        UserDefaults.standard.set([0, 0, 0, 0], forKey: "passcode")
        appPassword = []
        checkAppPassword = []
        secondChance = 0
    }
    
    let ButtonImage : UIImageView = {
       let buttonImage = UIImageView()
        buttonImage.translatesAutoresizingMaskIntoConstraints = false
        buttonImage.contentMode = .scaleAspectFit
        return buttonImage
    }()
    
    let ButtonLabel: UILabel = {
       let buttonLabel = UILabel()
        buttonLabel.translatesAutoresizingMaskIntoConstraints = false
        return buttonLabel
    }()
    
    let LockSwitchButton : UISwitch = {
        let lockSwitchButton = UISwitch(frame: CGRect(x: 100, y: 100, width: 0, height: 0))
        // 스위치 버튼 사이즈 조정
        lockSwitchButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        lockSwitchButton.translatesAutoresizingMaskIntoConstraints = false
        lockSwitchButton.addTarget(self, action: #selector(lockSwitchButtonTouch), for: .valueChanged)
        if UserDefaults.standard.bool(forKey: "lockState") == true{
            lockSwitchButton.isOn = true
        } else {
            lockSwitchButton.isOn = false
        }
        return lockSwitchButton
    }()
    
    @objc func lockSwitchButtonTouch(_ sender: UISwitch){
        if sender.isOn == true {
            lockButtonOn()
        } else {
            lockButtonOff()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 30, left: 0, bottom: 20, right: 0))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(ButtonImage)
        contentView.addSubview(ButtonLabel)
        
        
        NSLayoutConstraint.activate([
            ButtonImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            ButtonImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ButtonImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -315),
            
            ButtonLabel.leadingAnchor.constraint(equalTo: ButtonImage.trailingAnchor, constant: 15),
            ButtonLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
        ])
    }

}

