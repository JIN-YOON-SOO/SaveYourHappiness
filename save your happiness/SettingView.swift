//
//  SettingView.swift
//  save your happiness
//
//  Created by 진윤수 on 2022/01/18.
//

import UIKit
//화면전환(글 등록, 상점, 셋팅 완료 -> 세군데 추가)

class CustomSettingCollectionView: UICollectionView{}

class SettingViewController:UIViewController{
    var totalItemArray : [Item] = []
    var basicItemArray : [Item] = []
    var itemImageName : [String] = [] // 전체 아이템 이름
    var itemCategory : [String] = [] // 전체 아이템의 카테고리
    var myItemImage : [UIImage?] = [] // 내가 가지고 있는 이미지 그 자체
    var myJarImage : [UIImage?] = []
    var myMemoImage : [UIImage?] = []
    var clickRow : Int = 0
    var imgNameArr = UserDefaults.standard.array(forKey: "myItemImage") as! [String] // 내가 가지고 있는 이미지 이름
    var imgJarNameArray : [String] = []
    var imgMemoNameArray : [String] = []
    var myItemCategoty : [String] = []
    
    func basicloadJsonFile(){
        guard let path = Bundle.main.path(forResource: "BasicItem", ofType: "json") else{
            return
        }
        guard let jsonString = try? String(contentsOfFile: path) else{
            return
        }
        let decoder = JSONDecoder()
        let data = jsonString.data(using: .utf8)
        if let data = data,
         let item = try? decoder.decode([Item].self, from: data){
            basicItemArray.append(contentsOf: item)
         }
    }
    
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
        for i in 0...basicItemArray.count-1{
            itemImageName.append(basicItemArray[i].imageName)
            itemCategory.append(basicItemArray[i].category)
        }
        for i in 0...totalItemArray.count-1{
            itemImageName.append(totalItemArray[i].imageName)
            itemCategory.append(totalItemArray[i].category)
        }
    }
    
    func getMyItemImage(){
        if imgNameArr.count == 0{
            return
        } else {
            for i in 0...imgNameArr.count-1{
                myItemImage.append(UIImage(named: imgNameArr[i]))
            }
        }
    }
    
    func getMyJarImage(){
        if imgNameArr.count != 0{
            for i in 0...imgNameArr.count-1{
                if myItemCategoty[i] == "jar"{
                    myJarImage.append(UIImage(named: imgNameArr[i]))
                    imgJarNameArray.append(imgNameArr[i])
                } else {
                    myMemoImage.append(UIImage(named: imgNameArr[i]))
                    imgMemoNameArray.append(imgNameArr[i])
                }
            }
        }
    }
    
    func getMyItemCategory(touchRow:Int) -> String{
        var nowCategoty : String = ""
        for i in 0...itemImageName.count-1{
            if imgNameArr[touchRow] == itemImageName[i]{
                nowCategoty = itemCategory[i]
            }
        }
        return nowCategoty
    }
    
    func getMyItemCategoryArray(){
        if imgNameArr.count != 0{
            for i in 0...imgNameArr.count-1{
                for j in 0...itemImageName.count-1{
                    if imgNameArr[i] == itemImageName[j]{
                        myItemCategoty.append(itemCategory[j])
                    }
                }
            }
        }
    }
    //ㄴㅔ비게이션 바 추가
    let SettingNavigationView: UIView = {
        let settingNavigationView = UIView()
        settingNavigationView.translatesAutoresizingMaskIntoConstraints = false
        return settingNavigationView
    }()
    
    let SettingLabel : UILabel = {
        let settingLabel = UILabel()
        settingLabel.translatesAutoresizingMaskIntoConstraints = false
        settingLabel.text = "나의 창고"
        settingLabel.textColor = .black
        settingLabel.backgroundColor = UIColor.white.withAlphaComponent(0)
        settingLabel.font = UIFont(name: "KCCMurukmuruk", size: 15)
        return settingLabel
    }()
    
    let SettingBackLabel : UILabel = {
        let settingBackLabel = UILabel()
        settingBackLabel.translatesAutoresizingMaskIntoConstraints = false
        settingBackLabel.textColor = .blue
        settingBackLabel.text = " ← 돌아가기"
        settingBackLabel.font = UIFont(name: "KCCMurukmuruk", size: 13)
        settingBackLabel.backgroundColor = UIColor.white.withAlphaComponent(0)
        return settingBackLabel
    }()
    
    let SettingBackButton : UIButton = {
        let settingBackButton = UIButton()
        settingBackButton.translatesAutoresizingMaskIntoConstraints = false
        settingBackButton.addTarget(self, action: #selector(settingBackButtonTouch), for: .touchUpInside)
        return settingBackButton
    }()
    
    @objc func settingBackButtonTouch(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    let SettingBackGround: UIView = {
        let settingBackGround = UIView()
        settingBackGround.translatesAutoresizingMaskIntoConstraints = false
        settingBackGround.backgroundColor = .white
        return settingBackGround
    }()
    
    let SettingCollectionViewJar : UICollectionView = {
        let settingCollectionViewJar = CustomSettingCollectionView(frame:CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        settingCollectionViewJar.backgroundColor = .white
        settingCollectionViewJar.translatesAutoresizingMaskIntoConstraints = false
        return settingCollectionViewJar
    }()
    
    let SettingCollectionViewMemo : UICollectionView = {
        let settingCollectionViewMemo = CustomSettingCollectionView(frame:CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        settingCollectionViewMemo.backgroundColor = .white
        settingCollectionViewMemo.translatesAutoresizingMaskIntoConstraints = false
        return settingCollectionViewMemo
    }()
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(SettingBackGround)
        view.addSubview(SettingCollectionViewJar)
        view.addSubview(SettingCollectionViewMemo)
        view.addSubview(SettingNavigationView)
        view.addSubview(SettingLabel) //올리는 순서도 중요
        view.addSubview(SettingBackButton)
        view.addSubview(SettingBackLabel)
        
        
        getMyItemImage()
        basicloadJsonFile()
        loadJsonFile()
        getItemName()
        
        getMyItemCategoryArray()
        getMyJarImage()
        
        // 셀 재사용하려고 등록해줌
        SettingCollectionViewJar.register(SettingJarViewCell.classForCoder(), forCellWithReuseIdentifier: "SettingJarIdentifier")
        SettingCollectionViewJar.register(JarReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "JarHeader")
        SettingCollectionViewMemo.register(SettingMemoViewCell.classForCoder(), forCellWithReuseIdentifier: "SettingMemoIdentifier")
        SettingCollectionViewMemo.register(MemoReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MemoHeader")
        
        SettingCollectionViewJar.delegate = self
        SettingCollectionViewJar.dataSource = self
        SettingCollectionViewMemo.delegate = self
        SettingCollectionViewMemo.dataSource = self
        
        NSLayoutConstraint.activate([
            SettingNavigationView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            SettingNavigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            SettingNavigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            SettingLabel.topAnchor.constraint(equalTo: SettingNavigationView.topAnchor, constant: 10),
            SettingLabel.centerXAnchor.constraint(equalTo: SettingNavigationView.centerXAnchor),
            SettingLabel.centerYAnchor.constraint(equalTo: SettingNavigationView.centerYAnchor),
            SettingBackButton.leadingAnchor.constraint(equalTo: SettingNavigationView.leadingAnchor, constant: 30),
            SettingBackButton.centerYAnchor.constraint(equalTo: SettingLabel.centerYAnchor),
            SettingBackLabel.centerXAnchor.constraint(equalTo: SettingBackButton.centerXAnchor),
            SettingBackLabel.centerYAnchor.constraint(equalTo: SettingBackButton.centerYAnchor),
            SettingBackGround.topAnchor.constraint(equalTo: view.topAnchor),
            SettingBackGround.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            SettingBackGround.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            SettingBackGround.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            SettingCollectionViewJar.topAnchor.constraint(equalTo: SettingBackGround.topAnchor, constant: 130),
            SettingCollectionViewJar.bottomAnchor.constraint(equalTo: SettingBackGround.bottomAnchor, constant: -UIScreen.main.bounds.height / 2),
            SettingCollectionViewJar.leadingAnchor.constraint(equalTo: SettingBackGround.leadingAnchor, constant: 10),
            SettingCollectionViewJar.trailingAnchor.constraint(equalTo: SettingBackGround.trailingAnchor, constant: -10),
            
            SettingCollectionViewMemo.topAnchor.constraint(equalTo: SettingBackGround.topAnchor, constant: UIScreen.main.bounds.height / 2 + 50),
            SettingCollectionViewMemo.bottomAnchor.constraint(equalTo: SettingBackGround.bottomAnchor, constant: 50),
            SettingCollectionViewMemo.leadingAnchor.constraint(equalTo: SettingBackGround.leadingAnchor, constant: 10),
            SettingCollectionViewMemo.trailingAnchor.constraint(equalTo: SettingBackGround.trailingAnchor, constant: -10)
        ])
    }
}

// delegate - 셀에게 들어온 동작에 대해 처리, datasorce - 데이터를 받아와서 셀에 띄워주는 역할, delegateflowlayout - 셀 배치, 정렬을 담당
extension SettingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    //flowlayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
    
    //datasorce
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var jarCount = 0
        var memoCount = 0
        if myItemCategoty.count != 0{
            for i in 0...myItemCategoty.count-1{
                if myItemCategoty[i] == "jar"{
                    jarCount += 1
                } else {
                    memoCount += 1
                }
            }
        }
        if collectionView == SettingCollectionViewJar {
            return jarCount
        } else {
            return memoCount
        }
    }
    //delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == SettingCollectionViewJar {
            clickRow = indexPath.row
            UserDefaults.standard.set(imgJarNameArray[clickRow], forKey: "presentJarImage")
        } else {
            clickRow = indexPath.row
            UserDefaults.standard.set(imgMemoNameArray[clickRow], forKey: "presentMemoImage")
        }
        self.dismiss(animated: true, completion: {})
    }
    
    //datasorce
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == SettingCollectionViewJar{
            let cellJar = SettingCollectionViewJar.dequeueReusableCell(withReuseIdentifier: "SettingJarIdentifier", for: indexPath) as! SettingJarViewCell
            cellJar.ItemImage.image = myJarImage[indexPath.row]
            //이미지 올랴라
            return cellJar
        } else {
            let cellMemo = SettingCollectionViewMemo.dequeueReusableCell(withReuseIdentifier: "SettingMemoIdentifier", for: indexPath) as! SettingMemoViewCell
            cellMemo.ItemImage.image = myMemoImage[indexPath.row]
            //이미지 올랴라
            return cellMemo
        }
    }
    
    // datasorce
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == SettingCollectionViewJar{
            let JarHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "JarHeader", for: indexPath) as! JarReusableView
            JarHeaderView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.4)
            JarHeaderView.JarLabel.text = "나의 소중한 유리병"
            return JarHeaderView
        } else {
            let MemoHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MemoHeader", for: indexPath) as! MemoReusableView
            MemoHeaderView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.4)
            MemoHeaderView.MemoLabel.text = "나의 소중한 메모지"
            return MemoHeaderView
        }
    }
    
    //flowlayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection  section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 30)
    }
}

class SettingJarViewCell: UICollectionViewCell{
    let ItemImageLocation : UIView = {
        let itemImageLocation = UIView()
        itemImageLocation.translatesAutoresizingMaskIntoConstraints = false
        itemImageLocation.backgroundColor = UIColor.white.withAlphaComponent(0)
        itemImageLocation.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return itemImageLocation
    }()
    
    let ItemImage: UIImageView = {
        let itemImage = UIImageView()
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        itemImage.contentMode = .scaleAspectFit
        itemImage.backgroundColor = UIColor.white.withAlphaComponent(0)
        return itemImage
    }()
    
    /*
    designated init - 지정 이니셜라이저 : 클래스의 property 중 하나라도 빠뜨리면 오류발생
    convenience init - 보조 이니셜라이저 : designated init의 파라미터 중 일부를 기본값으로 설정할 수 있음
    따라서 convenience init을 쓰고 싶으면 designated init을 먼저 선언해야함
     
    스위프트 상속 - 서브 클래스가 수퍼 클래스의 이니셜라이저들을 상속받지 않는 것이 기본 원칙
    특별한 경우에만 자동 상속 허용
    1. 자식 클래스에서 추가된 저장 프로퍼티가 모두 디폴트 값을 가지고 추가적인 이니셜라이저를 지정하지 않았을 때
    2. 부모의 이니셜라이저를 상속 받았거나 부모의 모든 지정 이니셜라이저를 오버라이드 했을 경우
    
     override init(frame:CGRect) 이게 convenience init => 일부 지정 이니셜라이즈를 오버라이드 한 경우
    이니셜라이저 상속을 포기한게 되어버림
    문제 - required init?(coder: NSCoder) 상속 못받아요.. -> 따라서 상속 받는다고 코드로 작성해야함
    */

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame:CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(ItemImageLocation)
        contentView.addSubview(ItemImage)
        
        contentView.backgroundColor = .white
        
        
        NSLayoutConstraint.activate([
            ItemImageLocation.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            ItemImageLocation.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            ItemImageLocation.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ItemImageLocation.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            ItemImage.centerXAnchor.constraint(equalTo: ItemImageLocation.centerXAnchor),
            ItemImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ItemImage.topAnchor.constraint(equalTo: ItemImageLocation.topAnchor),
            ItemImage.bottomAnchor.constraint(equalTo: ItemImageLocation.bottomAnchor)
        ])
    }
}
// frame과 bounds의 차이 : frame은 수퍼뷰의 원점을 원점으로 삼고 bounds는 자기자신의 원점을 원점을로 삼음
class SettingMemoViewCell: UICollectionViewCell{
    let ItemImageLocation : UIView = {
        let itemImageLocation = UIView()
        itemImageLocation.translatesAutoresizingMaskIntoConstraints = false
        itemImageLocation.backgroundColor = UIColor.white.withAlphaComponent(0)
        itemImageLocation.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return itemImageLocation
    }()
    
    let ItemImage: UIImageView = {
        let itemImage = UIImageView()
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        itemImage.contentMode = .scaleAspectFit
        itemImage.backgroundColor = UIColor.white.withAlphaComponent(0)
        return itemImage
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame:CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(ItemImageLocation)
        contentView.addSubview(ItemImage)
        
        contentView.backgroundColor = .white
        
        
        NSLayoutConstraint.activate([
            ItemImageLocation.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            ItemImageLocation.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            ItemImageLocation.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ItemImageLocation.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            ItemImage.centerXAnchor.constraint(equalTo: ItemImageLocation.centerXAnchor),
            ItemImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ItemImage.topAnchor.constraint(equalTo: ItemImageLocation.topAnchor),
            ItemImage.bottomAnchor.constraint(equalTo: ItemImageLocation.bottomAnchor)
            
        ])
    }
}

class JarReusableView : UICollectionReusableView {
    let JarLabel : UILabel = {
        let jarLabel = UILabel()
        jarLabel.translatesAutoresizingMaskIntoConstraints = false
        jarLabel.textAlignment = .left
        jarLabel.font = UIFont(name: "KCCMurukmuruk", size: 15)
        jarLabel.textColor = .white
        jarLabel.isUserInteractionEnabled = false
        return jarLabel
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame:CGRect) {
        super.init(frame: .zero)
        self.addSubview(JarLabel)
        
        
        NSLayoutConstraint.activate([
            JarLabel.topAnchor.constraint(equalTo: self.topAnchor),
            JarLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            JarLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
class MemoReusableView : UICollectionReusableView {
    let MemoLabel : UILabel = {
        let memoLabel = UILabel()
        memoLabel.translatesAutoresizingMaskIntoConstraints = false
        memoLabel.textAlignment = .left
        memoLabel.text = "내 소중한 메모지"
        memoLabel.font = UIFont(name: "KCCMurukmuruk", size: 15)
        memoLabel.textColor = .white
        memoLabel.isUserInteractionEnabled = false
        return memoLabel
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame:CGRect) {
        super.init(frame: .zero)
        self.addSubview(MemoLabel)
        
        
        NSLayoutConstraint.activate([
            MemoLabel.topAnchor.constraint(equalTo: self.topAnchor),
            MemoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            MemoLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}


