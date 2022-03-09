//
//  StoreView.swift
//  save your happiness
//
//  Created by 진윤수 on 2022/01/13.
//

import UIKit

class CustomCollectionView: UICollectionView{}

class StoreViewController:UIViewController{
    var totalItemArray : [Item] = []
    var itemName : [String] = []
    var itemStory : [String] = []
    var itemPrice : [Int] = []
    var itemImageName : [String] = []
    var itemCategory : [String] = []
    var itemImgName : [UIImage?] = []
    var clickRow : Int = 0
    
    // 셀 터치하면 구매 확인창 뜸 -> 함수
    func purchase(money:Int, nowRow: Int){
        if money >= itemPrice[nowRow]{
            UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "mycoin") - itemPrice[nowRow], forKey: "mycoin")
            var imageNameArr = UserDefaults.standard.array(forKey: "myItemImage") as! [String]
            if imageNameArr.contains(itemImageName[nowRow]){ // 구매 항목 확인(산걸 다시 살 수는 없으니까..)
                let alreadyGetAlert = UIAlertController(title: "이미 구매한 항목이에요", message: "다른 것을 구매해주세요", preferredStyle: .alert)
                let goback = UIAlertAction(title: "돌아가기", style: .default, handler: nil)
                alreadyGetAlert.addAction(goback)
                present(alreadyGetAlert, animated: true, completion: nil)
            }else{
                imageNameArr.append(itemImageName[nowRow])
                UserDefaults.standard.set(imageNameArr, forKey: "myItemImage")
            }
        }else{
            // 알림으로 바꾸기 - 바꿈
            let noMoneyAlert = UIAlertController(title: "코인이 부족해요", message: "행복을 더 담아주세요", preferredStyle: .alert)
            let back = UIAlertAction(title: "돌아가기", style: .default, handler: nil)
            noMoneyAlert.addAction(back)
            present(noMoneyAlert, animated: true, completion: nil)
        }
    }
    
    let StoreNavigationView: UIView = {
        let storeNavigationView = UIView()
        storeNavigationView.translatesAutoresizingMaskIntoConstraints = false
        return storeNavigationView
    }()
    
    let StoreNavigationLabel: UILabel = {
        let storeNavigationLabel = UILabel()
        storeNavigationLabel.translatesAutoresizingMaskIntoConstraints = false
        storeNavigationLabel.text = "조그만 가게"
        storeNavigationLabel.textColor = .black
        storeNavigationLabel.backgroundColor = UIColor.white.withAlphaComponent(0)
        storeNavigationLabel.font = UIFont(name: "KCCMurukmuruk", size: 15)
        return storeNavigationLabel
    }()
    
    let StoreBackLabel : UILabel = {
        let storeBackLabel = UILabel()
        storeBackLabel.translatesAutoresizingMaskIntoConstraints = false
        storeBackLabel.textColor = .blue
        storeBackLabel.text = " ← 돌아가기"
        storeBackLabel.font = UIFont(name: "KCCMurukmuruk", size: 13)
        storeBackLabel.backgroundColor = UIColor.white.withAlphaComponent(0)
        return storeBackLabel
    }()
    
    @objc func storeBackButtonTouch(_ sender: UIButton){
            self.dismiss(animated: true, completion: nil)
    }
    let StoreBackButton : UIButton = {
        let storeBackButton = UIButton()
        storeBackButton.translatesAutoresizingMaskIntoConstraints = false
        storeBackButton.addTarget(self, action: #selector(storeBackButtonTouch), for: .touchUpInside)
        return storeBackButton
    }()
    
    let MyStorageButton : UIButton = {
       let myStorageButton = UIButton()
        myStorageButton.translatesAutoresizingMaskIntoConstraints = false
        myStorageButton.setImage(UIImage(named: "mystorage.png"), for: .normal)
        myStorageButton.imageView?.contentMode = .scaleAspectFit
        myStorageButton.addTarget(self, action: #selector(myStorageTouch), for: .touchUpInside)
        return myStorageButton
    }()
    
    @objc func myStorageTouch(_sender: UIButton){
        let settingViewController = SettingViewController()
        settingViewController.modalPresentationStyle = .fullScreen
        present(settingViewController, animated: true, completion: nil)
    }
    
    let StoreBackGround : UIView = {
        let storeBackGround = UIView()
        storeBackGround.translatesAutoresizingMaskIntoConstraints = false
        storeBackGround.backgroundColor = .white
        return storeBackGround
    }()
    
    let StoreCollectionView : UICollectionView = {
        //CGRect.zero => (x: 0, y: 0, width: 0, height: 0)
        let storeCollectionView = CustomCollectionView(frame:CGRect.zero, collectionViewLayout:UICollectionViewFlowLayout.init())
        storeCollectionView.backgroundColor = .white
        storeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        storeCollectionView.showsVerticalScrollIndicator = false
        return storeCollectionView
    }()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(StoreBackGround)
        view.addSubview(StoreCollectionView)
        view.addSubview(StoreNavigationView)
        view.addSubview(StoreNavigationLabel)
        view.addSubview(StoreBackButton)
        view.addSubview(StoreBackLabel)
        
        StoreCollectionView.register(StoreViewCell.classForCoder(), forCellWithReuseIdentifier: "cellIndentifier")
        StoreCollectionView.delegate = self
        StoreCollectionView.dataSource = self
        
        loadJsonFile()
        getItemName()
        
        NSLayoutConstraint.activate([
            StoreNavigationView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            StoreNavigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            StoreNavigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            StoreNavigationLabel.topAnchor.constraint(equalTo: StoreNavigationView.topAnchor, constant: 10),
            StoreNavigationLabel.centerXAnchor.constraint(equalTo: StoreNavigationView.centerXAnchor),
            StoreNavigationLabel.centerYAnchor.constraint(equalTo: StoreNavigationView.centerYAnchor),
            
            StoreBackButton.centerYAnchor.constraint(equalTo: StoreNavigationLabel.centerYAnchor),
            StoreBackButton.leadingAnchor.constraint(equalTo: StoreNavigationView.leadingAnchor, constant: 30),
            StoreBackLabel.centerXAnchor.constraint(equalTo: StoreBackButton.centerXAnchor),
            StoreBackLabel.centerYAnchor.constraint(equalTo: StoreBackButton.centerYAnchor),
            
    
            StoreBackGround.topAnchor.constraint(equalTo: view.topAnchor),
            StoreBackGround.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            StoreBackGround.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            StoreBackGround.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            StoreCollectionView.topAnchor.constraint(equalTo: StoreBackGround.topAnchor,constant: 130),
            StoreCollectionView.bottomAnchor.constraint(equalTo: StoreBackGround.safeAreaLayoutGuide.bottomAnchor),
            StoreCollectionView.leadingAnchor.constraint(equalTo: StoreBackGround.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            StoreCollectionView.trailingAnchor.constraint(equalTo: StoreBackGround.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
        ])
    }
}

extension StoreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 300, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalItemArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        _ = collectionView.cellForItem(at: indexPath) as? StoreViewCell
        clickRow = indexPath.row
        
        let alert = UIAlertController(title: "구매하시겠어요?", message: "확인 버튼을 눌러주세요", preferredStyle: .alert)
        let action = UIAlertAction(title:"확인", style: .default, handler:{ [self]
            Void in
            purchase(money: UserDefaults.standard.integer(forKey: "mycoin"), nowRow: self.clickRow)
        })
        let cancle = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(cancle)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = StoreCollectionView.dequeueReusableCell(withReuseIdentifier: "cellIndentifier", for: indexPath) as! StoreViewCell
        // 위임
        //cell.buttonDelegate = self
        
        cell.JarImage.image = itemImgName[indexPath.row] // 이미지
        cell.JarName.text = itemName[indexPath.row] // 이름
        cell.JarStory.text = itemStory[indexPath.row] // 설명
        cell.JarPrice.text = String(itemPrice[indexPath.row]) // 가격
        
        // cell 모서리 둥글게 + 그림자 효과
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 1.0
        cell.layer.shadowRadius = 10
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        return cell
    }
}
//  버튼 프로토콜
protocol ButtonTouchDelegate: AnyObject{
    func BuyButtonTouch()
}

class StoreViewCell: UICollectionViewCell{
     
    // 위임자 설정
    var buttonDelegate: ButtonTouchDelegate?
    // 아이템 사진 영역
    let JarImageLocation : UIView = {
        let jarImageLocation = UIView()
        jarImageLocation.translatesAutoresizingMaskIntoConstraints = false
        jarImageLocation.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        // frame superview(지금 뷰의 부모) 기준으로 원점 설정 bound 지금 뷰를 기준으로 원점 설정
        jarImageLocation.frame = CGRect(x: 0, y: 0, width: 100, height: 180)
        //jarImageLocation.layer.shadowColor = UIColor.black.cgColor
        //jarImageLocation.layer.shadowOpacity = 1.0
        //jarImageLocation.layer.shadowRadius = 10
        jarImageLocation.layer.cornerRadius = 10
        jarImageLocation.layer.masksToBounds = true
        return jarImageLocation
    }()
    // 아이템 사진
    let JarImage: UIImageView = {
        let jarImage = UIImageView()
        jarImage.translatesAutoresizingMaskIntoConstraints = false
        jarImage.contentMode = .scaleAspectFit
        jarImage.backgroundColor = UIColor.white.withAlphaComponent(0)
        return jarImage
    }()
    // 아이템 이름
    let JarName: UILabel = {
        let jarName = UILabel()
        jarName.translatesAutoresizingMaskIntoConstraints = false
        jarName.textColor = .black
        jarName.font = UIFont(name: "KCCMurukmuruk", size: 15)
        jarName.textAlignment = .center
        return jarName
    }()
    
    // 아이템 설명
    let JarStory: UILabel = {
        let jarStory = UILabel()
        jarStory.translatesAutoresizingMaskIntoConstraints = false
        jarStory.textColor = .black
        jarStory.font = UIFont(name: "KCCMurukmuruk", size: 10)
        jarStory.textAlignment = .center
        return jarStory
    }()
    
    // 아이템 가격
    let JarPrice: UILabel = {
        let jarPrice = UILabel()
        jarPrice.translatesAutoresizingMaskIntoConstraints = false
        jarPrice.textColor = .black
        jarPrice.font = UIFont(name: "KCCMurukmuruk", size: 12)
        jarPrice.textAlignment = .center
        return jarPrice
    }()
    /*
    // 아이템 구매 버튼
    let BuyButton: UIButton = {
        let buyButton = UIButton()
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        buyButton.setTitle("구매하기", for: .normal)
        buyButton.setTitleColor(.black, for: .normal)
        buyButton.titleLabel?.font = UIFont(name: "KCCMurukmuruk", size: 12)
        buyButton.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        buyButton.layer.cornerRadius = 10
        return buyButton
    }()
    
    @objc func BuyButtonClick(_sender: UIButton){
        buttonDelegate?.BuyButtonTouch() // 위임자야 이 함수 좀 대신 처리해줘
        
    }*/
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(JarImageLocation)
        contentView.addSubview(JarName)
        contentView.addSubview(JarStory)
        contentView.addSubview(JarPrice)
        //contentView.addSubview(BuyButton)
        contentView.addSubview(JarImage)
        
        //self.BuyButton.addTarget(self, action: #selector(BuyButtonClick), for: .touchUpInside)
        
        contentView.backgroundColor = UIColor(displayP3Red: 249/255, green: 249/255, blue: 144/255, alpha: 1.0)
        
        NSLayoutConstraint.activate([
            JarImageLocation.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            JarImageLocation.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            JarImageLocation.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            JarImageLocation.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor, constant: 10),
            JarName.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            JarName.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor),
            JarName.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            JarStory.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor),
            JarStory.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            JarStory.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor),
            //BuyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            //BuyButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            JarPrice.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            JarPrice.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor, constant: 10),
            JarPrice.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            JarImage.centerXAnchor.constraint(equalTo: JarImageLocation.centerXAnchor),
            JarImage.centerYAnchor.constraint(equalTo: JarImageLocation.centerYAnchor),
            JarImage.topAnchor.constraint(equalTo: JarImageLocation.topAnchor),
            JarImage.bottomAnchor.constraint(equalTo: JarImageLocation.bottomAnchor)
        ])
    }
}
/*
// collectio view가 있는 ViewController로 이동
extension StoreViewController: ButtonTouchDelegate{
    func BuyButtonTouch(){
        if mycoin.coin >= itemPrice[clickRow]{
            mycoin.coin -= itemPrice[clickRow]
            print(clickRow)
            print(mycoin.coin)
        }else{
            print("돈 없어..")
        }
    }
    
}
*/
