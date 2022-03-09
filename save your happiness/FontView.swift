//
//  FontView.swift
//  save your happiness
//
//  Created by 진윤수 on 2022/02/14.
//

import UIKit

struct AppFontName {
    static let fontNum = 9
    static let Ohsquareair = "Cafe24-Ohsquareair"
    static let Danjunghae = "Cafe24Danjunghae"
    static let Dongdong = "Cafe24Dongdong"
    static let Oneprettynight = "Cafe24Oneprettynight"
    static let Shiningstar = "Cafe24Shiningstar"
    static let Simplehae = "Cafe24Simplehae"
    static let Ssukssuk = "Cafe24Ssukssuk"
    static let SsurroundAir = "Cafe24SsurroundAir"
    static let Syongsyong = "Cafe24Syongsyong"
}

var myfontName = AppFontName.Ohsquareair
var lastfontTouchRow : IndexPath?
var cellIsSelectd : Bool = false

class FontViewController : UIViewController {
    
    let FontSettingView : UIView = {
       let fontSettingView = UIView()
        fontSettingView.translatesAutoresizingMaskIntoConstraints = false
        fontSettingView.backgroundColor = .white
        return fontSettingView
    }()
    
    let FontPreviewImageView : UIImageView = {
        let fontPreviewImageView = UIImageView()
        fontPreviewImageView.translatesAutoresizingMaskIntoConstraints = false
        fontPreviewImageView.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)
        fontPreviewImageView.image = UIImage(named: "rectangle.png")
        fontPreviewImageView.contentMode = .scaleAspectFit
        return fontPreviewImageView
    }()
    
    let FontPreviewView : UITextView = {
        let fontPreviewView = UITextView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        fontPreviewView.translatesAutoresizingMaskIntoConstraints = false
        fontPreviewView.isUserInteractionEnabled = false
        fontPreviewView.text = "오늘 붕어빵을 파는 곳을 발견해서 사왔다. \n 너무 따뜻하고 맛있어서 행복해!"
        fontPreviewView.textAlignment = NSTextAlignment.center
        fontPreviewView.isScrollEnabled = false
        fontPreviewView.backgroundColor = .clear
        fontPreviewView.font = .systemFont(ofSize: 18)
        return fontPreviewView
    }()
    
    let FontSettingTableView : UITableView = {
       let fontSettingTableView = UITableView()
        fontSettingTableView.translatesAutoresizingMaskIntoConstraints = false
        fontSettingTableView.backgroundColor = .clear
        fontSettingTableView.separatorStyle = .none
        fontSettingTableView.alwaysBounceVertical = false
        fontSettingTableView.isScrollEnabled = false
        return fontSettingTableView
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
        UserDefaults.standard.set(myfontName, forKey: "myFont")
        print(myfontName)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(FontSettingView)
        view.addSubview(FontPreviewImageView)
        view.addSubview(FontPreviewView)
        view.addSubview(FontSettingTableView)
        view.addSubview(BackButton)
        
        FontSettingTableView.delegate = self
        FontSettingTableView.dataSource = self
        FontSettingTableView.register(FontSettingTableViewCell.self, forCellReuseIdentifier: "FontSettingTableViewCell")

        NSLayoutConstraint.activate([
            FontSettingView.topAnchor.constraint(equalTo: view.topAnchor),
            FontSettingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            FontSettingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            FontSettingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            FontPreviewImageView.topAnchor.constraint(equalTo: FontSettingView.topAnchor, constant: 60),
            FontPreviewImageView.leadingAnchor.constraint(equalTo: FontSettingView.leadingAnchor, constant: 5),
            FontPreviewImageView.trailingAnchor.constraint(equalTo: FontSettingView.trailingAnchor, constant: -5),
            FontPreviewImageView.bottomAnchor.constraint(equalTo: FontSettingView.bottomAnchor, constant: -UIScreen.main.bounds.height / 2),

            FontPreviewView.centerXAnchor.constraint(equalTo: FontPreviewImageView.centerXAnchor),
            FontPreviewView.centerYAnchor.constraint(equalTo: FontPreviewImageView.centerYAnchor),
            
            FontSettingTableView.topAnchor.constraint(equalTo: FontPreviewImageView.bottomAnchor),
            FontSettingTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            FontSettingTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            FontSettingTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            BackButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            BackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
        ])
    }
}

extension FontViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppFontName.fontNum
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell : FontSettingTableViewCell = tableView.cellForRow(at: indexPath) as! FontSettingTableViewCell
        
        switch indexPath.row {
        case 0:
            if cellIsSelectd == true{
                tableView.deselectRow(at: lastfontTouchRow!, animated: false)
                let lastCell :FontSettingTableViewCell = tableView.cellForRow(at: lastfontTouchRow!) as! FontSettingTableViewCell
                lastCell.CheckBox.image = UIImage(named: "box.png")
                
            }
            myfontName = AppFontName.Ohsquareair
            lastfontTouchRow = indexPath
            cell.CheckBox.image = UIImage(named: "checkbox.png")
            cellIsSelectd = true
            FontPreviewView.font = UIFont(name: AppFontName.Ohsquareair, size: 18)
        case 1:
            if cellIsSelectd == true{
                tableView.deselectRow(at: lastfontTouchRow!, animated: false)
                let lastCell :FontSettingTableViewCell = tableView.cellForRow(at: lastfontTouchRow!) as! FontSettingTableViewCell
                lastCell.CheckBox.image = UIImage(named: "box.png")
                
            }
            myfontName = AppFontName.Danjunghae
            lastfontTouchRow = indexPath
            cell.CheckBox.image = UIImage(named: "checkbox.png")
            cellIsSelectd = true
            FontPreviewView.font = UIFont(name: AppFontName.Danjunghae, size: 18)
        case 2:
            if cellIsSelectd == true{
                tableView.deselectRow(at: lastfontTouchRow!, animated: false)
                let lastCell :FontSettingTableViewCell = tableView.cellForRow(at: lastfontTouchRow!) as! FontSettingTableViewCell
                lastCell.CheckBox.image = UIImage(named: "box.png")
                
            }
            myfontName = AppFontName.Dongdong
            lastfontTouchRow = indexPath
            cell.CheckBox.image = UIImage(named: "checkbox.png")
            cellIsSelectd = true
            FontPreviewView.font = UIFont(name: AppFontName.Dongdong, size: 18)
        case 3:
            if cellIsSelectd == true{
                tableView.deselectRow(at: lastfontTouchRow!, animated: false)
                let lastCell :FontSettingTableViewCell = tableView.cellForRow(at: lastfontTouchRow!) as! FontSettingTableViewCell
                lastCell.CheckBox.image = UIImage(named: "box.png")
                
            }
            myfontName = AppFontName.Oneprettynight
            lastfontTouchRow = indexPath
            cell.CheckBox.image = UIImage(named: "checkbox.png")
            cellIsSelectd = true
            FontPreviewView.font = UIFont(name: AppFontName.Oneprettynight, size: 18)
        case 4:
            if cellIsSelectd == true{
                tableView.deselectRow(at: lastfontTouchRow!, animated: false)
                let lastCell :FontSettingTableViewCell = tableView.cellForRow(at: lastfontTouchRow!) as! FontSettingTableViewCell
                lastCell.CheckBox.image = UIImage(named: "box.png")
                
            }
            myfontName = AppFontName.Shiningstar
            lastfontTouchRow = indexPath
            cell.CheckBox.image = UIImage(named: "checkbox.png")
            cellIsSelectd = true
            FontPreviewView.font = UIFont(name: AppFontName.Shiningstar, size: 18)
        case 5:
            if cellIsSelectd == true{
                tableView.deselectRow(at: lastfontTouchRow!, animated: false)
                let lastCell :FontSettingTableViewCell = tableView.cellForRow(at: lastfontTouchRow!) as! FontSettingTableViewCell
                lastCell.CheckBox.image = UIImage(named: "box.png")
                
            }
            myfontName = AppFontName.Simplehae
            lastfontTouchRow = indexPath
            cell.CheckBox.image = UIImage(named: "checkbox.png")
            cellIsSelectd = true
            FontPreviewView.font = UIFont(name: AppFontName.Simplehae, size: 18)
        case 6:
            if cellIsSelectd == true{
                tableView.deselectRow(at: lastfontTouchRow!, animated: false)
                let lastCell :FontSettingTableViewCell = tableView.cellForRow(at: lastfontTouchRow!) as! FontSettingTableViewCell
                lastCell.CheckBox.image = UIImage(named: "box.png")
                
            }
            myfontName = AppFontName.Ssukssuk
            lastfontTouchRow = indexPath
            cell.CheckBox.image = UIImage(named: "checkbox.png")
            cellIsSelectd = true
            FontPreviewView.font = UIFont(name: AppFontName.Ssukssuk, size: 18)
        case 7:
            if cellIsSelectd == true{
                tableView.deselectRow(at: lastfontTouchRow!, animated: false)
                let lastCell :FontSettingTableViewCell = tableView.cellForRow(at: lastfontTouchRow!) as! FontSettingTableViewCell
                lastCell.CheckBox.image = UIImage(named: "box.png")
                
            }
            myfontName = AppFontName.SsurroundAir
            lastfontTouchRow = indexPath
            cell.CheckBox.image = UIImage(named: "checkbox.png")
            cellIsSelectd = true
            FontPreviewView.font = UIFont(name: AppFontName.SsurroundAir, size: 17)
        case 8:
            if cellIsSelectd == true{
                tableView.deselectRow(at: lastfontTouchRow!, animated: false)
                let lastCell :FontSettingTableViewCell = tableView.cellForRow(at: lastfontTouchRow!) as! FontSettingTableViewCell
                lastCell.CheckBox.image = UIImage(named: "box.png")
                
            }
            myfontName = AppFontName.Syongsyong
            lastfontTouchRow = indexPath
            cell.CheckBox.image = UIImage(named: "checkbox.png")
            cellIsSelectd = true
            FontPreviewView.font = UIFont(name: AppFontName.Syongsyong, size: 18)
        default:
            if cellIsSelectd == true{
                tableView.deselectRow(at: lastfontTouchRow!, animated: false)
                let lastCell :FontSettingTableViewCell = tableView.cellForRow(at: lastfontTouchRow!) as! FontSettingTableViewCell
                lastCell.CheckBox.image = UIImage(named: "box.png")
                
            }
            myfontName = AppFontName.Ohsquareair
            lastfontTouchRow = indexPath
            cell.CheckBox.image = UIImage(named: "checkbox.png")
            cellIsSelectd = true
            FontPreviewView.font = UIFont(name: AppFontName.Ohsquareair, size: 18)
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FontSettingTableViewCell()
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        switch indexPath.row {
        case 0:
            cell.FontLabel.text = "카페24 아네모네 에어"
            cell.FontLabel.font = UIFont(name: AppFontName.Ohsquareair, size: 18)
        case 1:
            cell.FontLabel.text = "카페24 단정해"
            cell.FontLabel.font = UIFont(name: AppFontName.Danjunghae, size: 18)
        case 2:
            cell.FontLabel.text = "카페24 동동"
            cell.FontLabel.font = UIFont(name: AppFontName.Dongdong, size: 18)
        case 3:
            cell.FontLabel.text = "카페24 고운밤"
            cell.FontLabel.font = UIFont(name: AppFontName.Oneprettynight, size: 18)
        case 4:
            cell.FontLabel.text = "카페24 빛나는별"
            cell.FontLabel.font = UIFont(name: AppFontName.Shiningstar, size: 18)
        case 5:
            cell.FontLabel.text = "카페24 심플해"
            cell.FontLabel.font = UIFont(name: AppFontName.Simplehae, size: 18)
        case 6:
            cell.FontLabel.text = "카페24 쑥쑥"
            cell.FontLabel.font = UIFont(name: AppFontName.Ssukssuk, size: 18)
        case 7:
            cell.FontLabel.text = "카페24 써라운드 에어"
            cell.FontLabel.font = UIFont(name: AppFontName.SsurroundAir, size: 18)
        case 8:
            cell.FontLabel.text = "카페24 숑숑"
            cell.FontLabel.font = UIFont(name: AppFontName.Syongsyong, size: 18)
        default:
            cell.FontLabel.text = "카페24 아네모네 에어"
            cell.FontLabel.font = UIFont(name: AppFontName.Ohsquareair, size: 18)
        }

        return cell
    }
    
}

class FontSettingTableViewCell : UITableViewCell {
    
    let CheckBox : UIImageView = {
        let checkBox = UIImageView()
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        checkBox.image = UIImage(named: "box.png")
        checkBox.contentMode = .scaleAspectFit
        checkBox.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        return checkBox
    }()
    
    
    let FontLabel : UILabel = {
        let fontLabel = UILabel()
        fontLabel.translatesAutoresizingMaskIntoConstraints = false
        fontLabel.isUserInteractionEnabled = false
        return fontLabel
    }()
   
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(CheckBox)
        contentView.addSubview(FontLabel)
        
        NSLayoutConstraint.activate([
            CheckBox.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            CheckBox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 300),
            CheckBox.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            CheckBox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            FontLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            FontLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            FontLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
}


extension UIFontDescriptor.AttributeName {
    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}

extension UIFont {
    @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: myfontName, size: size)!
    }
    
    @objc convenience init(myCoder aDecoder: NSCoder){
        if let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor {
            self.init(name: myfontName, size:fontDescriptor.pointSize)!
        } else {
            self.init(myCoder: aDecoder)
        }
    }
        
    class func overrideInitialize() {
        if self == UIFont.self {
            let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:)))
            let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:)))
            method_exchangeImplementations(systemFontMethod!, mySystemFontMethod!)

            let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:)))
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:)))
            method_exchangeImplementations(initCoderMethod!, myInitCoderMethod!)
            }
        }
}


