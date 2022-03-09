//
//  LockView.swift
//  save your happiness
//
//  Created by 진윤수 on 2022/02/14.
//

import UIKit

var appPassword : [Int] = []
var checkAppPassword : [Int] = []
var secondChance : Int = 0

class LockViewController : UIViewController {
    
    let LockView : UIView = {
        let lockView = UIView()
        lockView.translatesAutoresizingMaskIntoConstraints = false
        lockView.backgroundColor = .white
       return lockView
    }()
    
    let LockImage : UIImageView = {
        let lockImage = UIImageView()
        lockImage.translatesAutoresizingMaskIntoConstraints = false
        lockImage.isUserInteractionEnabled = false
        lockImage.image = UIImage(named: "lock_setting.png")
        lockImage.contentMode = .scaleAspectFit
        return lockImage
    }()
    
    let LockLabel : UILabel = {
        let lockLabel = UILabel()
        lockLabel.translatesAutoresizingMaskIntoConstraints = false
        lockLabel.isUserInteractionEnabled = false
        lockLabel.text = "새 암호 입력"
        return lockLabel
    }()
    
    let OneCircle : UIImageView = {
        let oneCircle = UIImageView()
        oneCircle.translatesAutoresizingMaskIntoConstraints = false
        oneCircle.isUserInteractionEnabled = false
        oneCircle.bounds = CGRect(x: 0, y: 0, width: 16, height: 16)
        oneCircle.image = UIImage(named: "circle.png")
        oneCircle.contentMode = .scaleAspectFit
        return oneCircle
    }()
    
    let TwoCircle : UIImageView = {
        let twoCircle = UIImageView()
        twoCircle.translatesAutoresizingMaskIntoConstraints = false
        twoCircle.isUserInteractionEnabled = false
        twoCircle.bounds = CGRect(x: 0, y: 0, width: 16, height: 16)
        twoCircle.image = UIImage(named: "circle.png")
        twoCircle.contentMode = .scaleAspectFit
        return twoCircle
    }()
    
    let ThreeCircle : UIImageView = {
        let threeCircle = UIImageView()
        threeCircle.translatesAutoresizingMaskIntoConstraints = false
        threeCircle.isUserInteractionEnabled = false
        threeCircle.bounds = CGRect(x: 0, y: 0, width: 16, height: 16)
        threeCircle.image = UIImage(named: "circle.png")
        threeCircle.contentMode = .scaleAspectFit
        return threeCircle
    }()
    
    let FourCircle : UIImageView = {
        let fourCircle = UIImageView()
        fourCircle.translatesAutoresizingMaskIntoConstraints = false
        fourCircle.isUserInteractionEnabled = false
        fourCircle.bounds = CGRect(x: 0, y: 0, width: 16, height: 16)
        fourCircle.image = UIImage(named: "circle.png")
        fourCircle.contentMode = .scaleAspectFit
        return fourCircle
    }()
    
    func firstChangeCirle() {
        switch appPassword.count {
        case 1:
            OneCircle.image = UIImage(named:"blackcircle.png")
        case 2:
            TwoCircle.image = UIImage(named: "blackcircle.png")
        case 3:
            ThreeCircle.image = UIImage(named: "blackcircle.png")
        case 4:
            FourCircle.image = UIImage(named: "blackcircle.png")
        default:
            OneCircle.image = UIImage(named: "circle.png")
            TwoCircle.image = UIImage(named: "circle.png")
            ThreeCircle.image = UIImage(named: "circle.png")
            FourCircle.image = UIImage(named: "circle.png")
        }
    }
    
    func secondChangeCirle() {
        switch checkAppPassword.count {
        case 1:
            OneCircle.image = UIImage(named:"blackcircle.png")
        case 2:
            TwoCircle.image = UIImage(named: "blackcircle.png")
        case 3:
            ThreeCircle.image = UIImage(named: "blackcircle.png")
        case 4:
            FourCircle.image = UIImage(named: "blackcircle.png")
        default:
            OneCircle.image = UIImage(named: "circle.png")
            TwoCircle.image = UIImage(named: "circle.png")
            ThreeCircle.image = UIImage(named: "circle.png")
            FourCircle.image = UIImage(named: "circle.png")
        }
    }
    
    func deleteLastCircle(value: Int) {
        switch value {
        case 1:
            OneCircle.image = UIImage(named:"circle.png")
        case 2:
            TwoCircle.image = UIImage(named: "circle.png")
        case 3:
            ThreeCircle.image = UIImage(named: "circle.png")
        case 4:
            FourCircle.image = UIImage(named: "circle.png")
        default:
            OneCircle.image = UIImage(named: "circle.png")
            TwoCircle.image = UIImage(named: "circle.png")
            ThreeCircle.image = UIImage(named: "circle.png")
            FourCircle.image = UIImage(named: "circle.png")
        }
    }
    
    func secondDeleteLastCircle(value: Int) {
        switch value {
        case 1:
            OneCircle.image = UIImage(named:"circle.png")
        case 2:
            TwoCircle.image = UIImage(named: "circle.png")
        case 3:
            ThreeCircle.image = UIImage(named: "circle.png")
        case 4:
            FourCircle.image = UIImage(named: "circle.png")
        default:
            OneCircle.image = UIImage(named: "circle.png")
            TwoCircle.image = UIImage(named: "circle.png")
            ThreeCircle.image = UIImage(named: "circle.png")
            FourCircle.image = UIImage(named: "circle.png")
        }
    }
    
    let ZeroButton : UIButton = {
       let zeroButton = UIButton()
        zeroButton.translatesAutoresizingMaskIntoConstraints = false
        zeroButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        zeroButton.setImage(UIImage(named: "zero.png"), for: .normal)
        zeroButton.imageView?.contentMode = .scaleAspectFit
        zeroButton.imageView?.bounds = CGRect(x: 0, y: 0, width: 32, height: 32)
        zeroButton.layer.cornerRadius = 50
        zeroButton.addTarget(self, action: #selector(zeroButtonTouch), for: .touchUpInside)
        return zeroButton
    }()
    
    @objc func zeroButtonTouch(){
        if secondChance == 0{
            if appPassword.count < 4 {
                appPassword.append(0)
            }
            
            firstChangeCirle()
            
            if appPassword.count == 4 {
                secondChance += 1
                
            }
            
        } else {
            if checkAppPassword.count < 4 {
                checkAppPassword.append(0)
            }
            
            secondChangeCirle()
            
            if checkAppPassword.count == 4 {
                if appPassword == checkAppPassword{
                    UserDefaults.standard.set(true, forKey: "lockState")
                    UserDefaults.standard.set(appPassword, forKey: "passcode")
                    self.dismiss(animated: true, completion: nil)
                } else {
                    LockView.shakeDisplay()
                    checkAppPassword = []
                }
            }
        }
    }
    
    let OneButton : UIButton = {
       let oneButton = UIButton()
        oneButton.translatesAutoresizingMaskIntoConstraints = false
        oneButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        oneButton.setImage(UIImage(named: "one.png"), for: .normal)
        oneButton.imageView?.bounds = CGRect(x: 0, y: 0, width: 32, height: 32)
        oneButton.layer.cornerRadius = 50
        oneButton.imageView?.contentMode = .scaleAspectFit
        oneButton.addTarget(self, action: #selector(oneButtonTouch), for: .touchUpInside)
        return oneButton
    }()
    
    @objc func oneButtonTouch(){
        if secondChance == 0{
            if appPassword.count < 4 {
                appPassword.append(1)
            }
            
            firstChangeCirle()
            
            if appPassword.count == 4 {
                secondChance += 1
                OneCircle.image = UIImage(named: "circle.png")
                TwoCircle.image = UIImage(named: "circle.png")
                ThreeCircle.image = UIImage(named: "circle.png")
                FourCircle.image = UIImage(named: "circle.png")
            }
            
        } else {
            if checkAppPassword.count < 4 {
                checkAppPassword.append(1)
            }
            
            secondChangeCirle()
            
            if checkAppPassword.count == 4 {
                if appPassword == checkAppPassword{
                    UserDefaults.standard.set(true, forKey: "lockState")
                    UserDefaults.standard.set(appPassword, forKey: "passcode")
                    self.dismiss(animated: true, completion: nil)
                } else {
                    LockView.shakeDisplay()
                    checkAppPassword = []
                    OneCircle.image = UIImage(named: "circle.png")
                    TwoCircle.image = UIImage(named: "circle.png")
                    ThreeCircle.image = UIImage(named: "circle.png")
                    FourCircle.image = UIImage(named: "circle.png")
                }
            }
        }
    }
    
    let TwoButton : UIButton = {
       let twoButton = UIButton()
        twoButton.translatesAutoresizingMaskIntoConstraints = false
        twoButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        twoButton.setImage(UIImage(named: "two.png"), for: .normal)
        twoButton.imageView?.bounds = CGRect(x: 0, y: 0, width: 32, height: 32)
        twoButton.layer.cornerRadius = 50
        twoButton.imageView?.contentMode = .scaleAspectFit
        twoButton.addTarget(self, action: #selector(twoButtonTouch), for: .touchUpInside)
        return twoButton
    }()
    
    @objc func twoButtonTouch(){
        if secondChance == 0{
            if appPassword.count < 4 {
                appPassword.append(2)
            }
            
            firstChangeCirle()
            
            if appPassword.count == 4 {
                secondChance += 1
                OneCircle.image = UIImage(named: "circle.png")
                TwoCircle.image = UIImage(named: "circle.png")
                ThreeCircle.image = UIImage(named: "circle.png")
                FourCircle.image = UIImage(named: "circle.png")
                
            }
            
        } else {
            if checkAppPassword.count < 4 {
                checkAppPassword.append(2)
            }
            
            secondChangeCirle()
            
            if checkAppPassword.count == 4 {
                if appPassword == checkAppPassword{
                    UserDefaults.standard.set(true, forKey: "lockState")
                    UserDefaults.standard.set(appPassword, forKey: "passcode")
                    self.dismiss(animated: true, completion: nil)
                } else {
                    LockView.shakeDisplay()
                    checkAppPassword = []
                    OneCircle.image = UIImage(named: "circle.png")
                    TwoCircle.image = UIImage(named: "circle.png")
                    ThreeCircle.image = UIImage(named: "circle.png")
                    FourCircle.image = UIImage(named: "circle.png")
                }
            }
        }
    }
    
    let ThreeButton : UIButton = {
       let threeButton = UIButton()
        threeButton.translatesAutoresizingMaskIntoConstraints = false
        threeButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        threeButton.setImage(UIImage(named: "three.png"), for: .normal)
        threeButton.imageView?.bounds = CGRect(x: 0, y: 0, width: 32, height: 32)
        threeButton.layer.cornerRadius = 50
        threeButton.imageView?.contentMode = .scaleAspectFit
        threeButton.addTarget(self, action: #selector(threeButtonTouch), for: .touchUpInside)
        return threeButton
    }()
    
    @objc func threeButtonTouch(){
        if secondChance == 0{
            if appPassword.count < 4 {
                appPassword.append(3)
            }
            
            firstChangeCirle()
            
            if appPassword.count == 4 {
                secondChance += 1
                OneCircle.image = UIImage(named: "circle.png")
                TwoCircle.image = UIImage(named: "circle.png")
                ThreeCircle.image = UIImage(named: "circle.png")
                FourCircle.image = UIImage(named: "circle.png")
                
            }
            
        } else {
            if checkAppPassword.count < 4 {
                checkAppPassword.append(3)
            }
            
            secondChangeCirle()
            
            if checkAppPassword.count == 4 {
                if appPassword == checkAppPassword{
                    UserDefaults.standard.set(true, forKey: "lockState")
                    UserDefaults.standard.set(appPassword, forKey: "passcode")
                    self.dismiss(animated: true, completion: nil)
                } else {
                    LockView.shakeDisplay()
                    checkAppPassword = []
                    OneCircle.image = UIImage(named: "circle.png")
                    TwoCircle.image = UIImage(named: "circle.png")
                    ThreeCircle.image = UIImage(named: "circle.png")
                    FourCircle.image = UIImage(named: "circle.png")
                }
            }
        }
    }
    
    let FourButton : UIButton = {
       let fourButton = UIButton()
        fourButton.translatesAutoresizingMaskIntoConstraints = false
        fourButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        fourButton.setImage(UIImage(named: "four.png"), for: .normal)
        fourButton.imageView?.bounds = CGRect(x: 0, y: 0, width: 32, height: 32)
        fourButton.layer.cornerRadius = 50
        fourButton.imageView?.contentMode = .scaleAspectFit
        fourButton.addTarget(self, action: #selector(fourButtonTouch), for: .touchUpInside)
        return fourButton
    }()
    
    @objc func fourButtonTouch(){
        if secondChance == 0{
            if appPassword.count < 4 {
                appPassword.append(4)
            }
        
            firstChangeCirle()
            
            if appPassword.count == 4 {
                secondChance += 1
                OneCircle.image = UIImage(named: "circle.png")
                TwoCircle.image = UIImage(named: "circle.png")
                ThreeCircle.image = UIImage(named: "circle.png")
                FourCircle.image = UIImage(named: "circle.png")
            }
            
        } else {
            
            if checkAppPassword.count < 4 {
                checkAppPassword.append(4)
            }
            
            secondChangeCirle()
            
            if checkAppPassword.count == 4 {
                if appPassword == checkAppPassword{
                    UserDefaults.standard.set(true, forKey: "lockState")
                    UserDefaults.standard.set(appPassword, forKey: "passcode")
                    self.dismiss(animated: true, completion: nil)
                } else {
                    LockView.shakeDisplay()
                    checkAppPassword = []
                    OneCircle.image = UIImage(named: "circle.png")
                    TwoCircle.image = UIImage(named: "circle.png")
                    ThreeCircle.image = UIImage(named: "circle.png")
                    FourCircle.image = UIImage(named: "circle.png")
                }
            }
        }
    }
    
    let FiveButton : UIButton = {
       let fiveButton = UIButton()
        fiveButton.translatesAutoresizingMaskIntoConstraints = false
        fiveButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        fiveButton.setImage(UIImage(named: "five.png"), for: .normal)
        fiveButton.imageView?.bounds = CGRect(x: 0, y: 0, width: 32, height: 32)
        fiveButton.imageView?.contentMode = .scaleAspectFit
        fiveButton.layer.cornerRadius = 50
        fiveButton.addTarget(self, action: #selector(fiveButtonTouch), for: .touchUpInside)
        return fiveButton
    }()
    
    @objc func fiveButtonTouch(){
        if secondChance == 0{
            if appPassword.count < 4 {
                appPassword.append(5)
            }
            
            firstChangeCirle()
            
            if appPassword.count == 4 {
                secondChance += 1
                OneCircle.image = UIImage(named: "circle.png")
                TwoCircle.image = UIImage(named: "circle.png")
                ThreeCircle.image = UIImage(named: "circle.png")
                FourCircle.image = UIImage(named: "circle.png")
                
            }
            
        } else {
            if checkAppPassword.count < 4 {
                checkAppPassword.append(5)
            }
            
            secondChangeCirle()
            
            if checkAppPassword.count == 4 {
                if appPassword == checkAppPassword{
                    UserDefaults.standard.set(true, forKey: "lockState")
                    UserDefaults.standard.set(appPassword, forKey: "passcode")
                    self.dismiss(animated: true, completion: nil)
                } else {
                    LockView.shakeDisplay()
                    checkAppPassword = []
                    OneCircle.image = UIImage(named: "circle.png")
                    TwoCircle.image = UIImage(named: "circle.png")
                    ThreeCircle.image = UIImage(named: "circle.png")
                    FourCircle.image = UIImage(named: "circle.png")
                }
            }
        }
    }
    
    let SixButton : UIButton = {
       let sixButton = UIButton()
        sixButton.translatesAutoresizingMaskIntoConstraints = false
        sixButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        sixButton.setImage(UIImage(named: "six.png"), for: .normal)
        sixButton.imageView?.bounds = CGRect(x: 0, y: 0, width: 32, height: 32)
        sixButton.layer.cornerRadius = 50
        sixButton.imageView?.contentMode = .scaleAspectFit
        sixButton.addTarget(self, action: #selector(sixButtonTouch), for: .touchUpInside)
        return sixButton
    }()
    
    @objc func sixButtonTouch(){
        if secondChance == 0{
            if appPassword.count < 4 {
                appPassword.append(6)
            }
            
            firstChangeCirle()
            
            if appPassword.count == 4 {
                secondChance += 1
                OneCircle.image = UIImage(named: "circle.png")
                TwoCircle.image = UIImage(named: "circle.png")
                ThreeCircle.image = UIImage(named: "circle.png")
                FourCircle.image = UIImage(named: "circle.png")
                
            }
            
        } else {
            if checkAppPassword.count < 4 {
                checkAppPassword.append(6)
            }
            
            secondChangeCirle()
            
            if checkAppPassword.count == 4 {
                if appPassword == checkAppPassword{
                    UserDefaults.standard.set(true, forKey: "lockState")
                    UserDefaults.standard.set(appPassword, forKey: "passcode")
                    self.dismiss(animated: true, completion: nil)
                } else {
                    LockView.shakeDisplay()
                    checkAppPassword = []
                    OneCircle.image = UIImage(named: "circle.png")
                    TwoCircle.image = UIImage(named: "circle.png")
                    ThreeCircle.image = UIImage(named: "circle.png")
                    FourCircle.image = UIImage(named: "circle.png")
                }
            }
        }
    }
    
    let SevenButton : UIButton = {
       let sevenButton = UIButton()
        sevenButton.translatesAutoresizingMaskIntoConstraints = false
        sevenButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        sevenButton.setImage(UIImage(named: "seven.png"), for: .normal)
        sevenButton.imageView?.bounds = CGRect(x: 0, y: 0, width: 32, height: 32)
        sevenButton.layer.cornerRadius = 50
        sevenButton.imageView?.contentMode = .scaleAspectFit
        sevenButton.addTarget(self, action: #selector(sevenButtonTouch), for: .touchUpInside)
        return sevenButton
    }()
    
    @objc func sevenButtonTouch(){
        if secondChance == 0{
            if appPassword.count < 4 {
                appPassword.append(7)
            }
            
            firstChangeCirle()
            
            if appPassword.count == 4 {
                secondChance += 1
                OneCircle.image = UIImage(named: "circle.png")
                TwoCircle.image = UIImage(named: "circle.png")
                ThreeCircle.image = UIImage(named: "circle.png")
                FourCircle.image = UIImage(named: "circle.png")
                
            }
            
        } else {
            if checkAppPassword.count < 4 {
                checkAppPassword.append(7)
            }
            
            secondChangeCirle()
            
            if checkAppPassword.count == 4 {
                if appPassword == checkAppPassword{
                    UserDefaults.standard.set(true, forKey: "lockState")
                    UserDefaults.standard.set(appPassword, forKey: "passcode")
                    self.dismiss(animated: true, completion: nil)
                } else {
                    LockView.shakeDisplay()
                    checkAppPassword = []
                    OneCircle.image = UIImage(named: "circle.png")
                    TwoCircle.image = UIImage(named: "circle.png")
                    ThreeCircle.image = UIImage(named: "circle.png")
                    FourCircle.image = UIImage(named: "circle.png")
                }
            }
        }
    }
    
    let EightButton : UIButton = {
       let eightButton = UIButton()
        eightButton.translatesAutoresizingMaskIntoConstraints = false
        eightButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        eightButton.setImage(UIImage(named: "eight.png"), for: .normal)
        eightButton.imageView?.bounds = CGRect(x: 0, y: 0, width: 32, height: 32)
        eightButton.layer.cornerRadius = 50
        eightButton.imageView?.contentMode = .scaleAspectFit
        eightButton.addTarget(self, action: #selector(eightButtonTouch), for: .touchUpInside)
        return eightButton
    }()
    
    @objc func eightButtonTouch(){
        if secondChance == 0{
            if appPassword.count < 4 {
                appPassword.append(8)
            }
            
            firstChangeCirle()
            
            if appPassword.count == 4 {
                secondChance += 1
                OneCircle.image = UIImage(named: "circle.png")
                TwoCircle.image = UIImage(named: "circle.png")
                ThreeCircle.image = UIImage(named: "circle.png")
                FourCircle.image = UIImage(named: "circle.png")
                
            }
            
        } else {
            if checkAppPassword.count < 4 {
                checkAppPassword.append(8)
            }
            
            secondChangeCirle()
            
            if checkAppPassword.count == 4 {
                if appPassword == checkAppPassword{
                    UserDefaults.standard.set(true, forKey: "lockState")
                    UserDefaults.standard.set(appPassword, forKey: "passcode")
                    self.dismiss(animated: true, completion: nil)
                } else {
                    LockView.shakeDisplay()
                    checkAppPassword = []
                    OneCircle.image = UIImage(named: "circle.png")
                    TwoCircle.image = UIImage(named: "circle.png")
                    ThreeCircle.image = UIImage(named: "circle.png")
                    FourCircle.image = UIImage(named: "circle.png")
                }
            }
        }
    }
    
    let NineButton : UIButton = {
       let nineButton = UIButton()
        nineButton.translatesAutoresizingMaskIntoConstraints = false
        nineButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        nineButton.setImage(UIImage(named: "nine.png"), for: .normal)
        nineButton.imageView?.bounds = CGRect(x: 0, y: 0, width: 32, height: 32)
        nineButton.layer.cornerRadius = 50
        nineButton.imageView?.contentMode = .scaleAspectFit
        nineButton.addTarget(self, action: #selector(nineButtonTouch), for: .touchUpInside)
        return nineButton
    }()
    
    @objc func nineButtonTouch(){
        if secondChance == 0{
            if appPassword.count < 4 {
                appPassword.append(9)
            }
            
            firstChangeCirle()
            
            if appPassword.count == 4 {
                secondChance += 1
                OneCircle.image = UIImage(named: "circle.png")
                TwoCircle.image = UIImage(named: "circle.png")
                ThreeCircle.image = UIImage(named: "circle.png")
                FourCircle.image = UIImage(named: "circle.png")
                
            }
            
        } else {
            if checkAppPassword.count < 4 {
                checkAppPassword.append(9)
            }
            
            secondChangeCirle()
            
            if checkAppPassword.count == 4 {
                if appPassword == checkAppPassword{
                    UserDefaults.standard.set(true, forKey: "lockState")
                    UserDefaults.standard.set(appPassword, forKey: "passcode")
                    self.dismiss(animated: true, completion: nil)
                } else {
                    LockView.shakeDisplay()
                    checkAppPassword = []
                    OneCircle.image = UIImage(named: "circle.png")
                    TwoCircle.image = UIImage(named: "circle.png")
                    ThreeCircle.image = UIImage(named: "circle.png")
                    FourCircle.image = UIImage(named: "circle.png")
                }
            }
        }
    }
    
    let DeleteButton : UIButton = {
        let deleteButton = UIButton()
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        deleteButton.setImage(UIImage(named: "delete.png"), for: .normal)
        deleteButton.imageView?.bounds = CGRect(x: 0, y: 0, width: 32, height: 32)
        deleteButton.layer.cornerRadius = 50
        deleteButton.imageView?.contentMode = .scaleAspectFit
        deleteButton.addTarget(self, action: #selector(deleteButtonTouch), for: .touchUpInside)
        return deleteButton
    }()
    
    @objc func deleteButtonTouch(){
        if secondChance == 0{
            let nowLength = appPassword.count
            if nowLength != 0{
                appPassword.removeLast()
                print(appPassword)
                deleteLastCircle(value: nowLength)
            }
            
        } else {
            let secondNowLength = checkAppPassword.count
            if secondNowLength != 0{
                checkAppPassword.removeLast()
                secondDeleteLastCircle(value: secondNowLength)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(LockView)
        LockView.addSubview(LockImage)
        LockView.addSubview(LockLabel)
        LockView.addSubview(OneCircle)
        LockView.addSubview(TwoCircle)
        LockView.addSubview(ThreeCircle)
        LockView.addSubview(FourCircle)
        LockView.addSubview(OneButton)
        LockView.addSubview(TwoButton)
        LockView.addSubview(ThreeButton)
        LockView.addSubview(FourButton)
        LockView.addSubview(FiveButton)
        LockView.addSubview(SixButton)
        LockView.addSubview(SevenButton)
        LockView.addSubview(EightButton)
        LockView.addSubview(NineButton)
        LockView.addSubview(ZeroButton)
        LockView.addSubview(DeleteButton)
        
        NSLayoutConstraint.activate([
            LockView.topAnchor.constraint(equalTo: view.topAnchor),
            LockView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            LockView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            LockView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            LockImage.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height / 6),
            LockImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            LockLabel.topAnchor.constraint(equalTo: LockImage.bottomAnchor, constant: 20),
            LockLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            OneCircle.topAnchor.constraint(equalTo: view.topAnchor, constant: 270),
            OneCircle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 75),
            OneCircle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -225),
            OneCircle.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -500),
            
            TwoCircle.topAnchor.constraint(equalTo: view.topAnchor, constant: 270),
            TwoCircle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 125),
            TwoCircle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -175),
            TwoCircle.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -500),
            
            ThreeCircle.topAnchor.constraint(equalTo: view.topAnchor, constant: 270),
            ThreeCircle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 175),
            ThreeCircle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -125),
            ThreeCircle.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -500),
            
            FourCircle.topAnchor.constraint(equalTo: view.topAnchor, constant: 270),
            FourCircle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 225),
            FourCircle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -75),
            FourCircle.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -500),
            
            OneButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 330),
            OneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            OneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -250),
            OneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -400),
    
            TwoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 330),
            TwoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150),
            TwoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150),
            TwoButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -400),
            
            ThreeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 330),
            ThreeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 250),
            ThreeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            ThreeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -400),
            
            FourButton.topAnchor.constraint(equalTo: OneButton.bottomAnchor, constant: 20),
            FourButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            FourButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -250),
            FourButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300),
            
            FiveButton.topAnchor.constraint(equalTo: TwoButton.bottomAnchor, constant: 20),
            FiveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150),
            FiveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150),
            FiveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300),
            
            SixButton.topAnchor.constraint(equalTo: ThreeButton.bottomAnchor, constant: 20),
            SixButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 250),
            SixButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            SixButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300),
            
            SevenButton.topAnchor.constraint(equalTo: FourButton.bottomAnchor, constant: 20),
            SevenButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            SevenButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -250),
            SevenButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            
            EightButton.topAnchor.constraint(equalTo: FiveButton.bottomAnchor, constant: 20),
            EightButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150),
            EightButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150),
            EightButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            
            NineButton.topAnchor.constraint(equalTo: SixButton.bottomAnchor, constant: 20),
            NineButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 250),
            NineButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            NineButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            
            ZeroButton.topAnchor.constraint(equalTo: EightButton.bottomAnchor, constant: 20),
            ZeroButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150),
            ZeroButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150),
            ZeroButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            
            DeleteButton.topAnchor.constraint(equalTo: NineButton.bottomAnchor, constant: 20),
            DeleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 260),
            DeleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            DeleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
        ])
    }
}

extension UIView {
    func shakeDisplay(){
        let shakeAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        shakeAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        shakeAnimation.duration = 0.5
        shakeAnimation.values = [-20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0]
        layer.add(shakeAnimation, forKey: "shake")
    }
}
