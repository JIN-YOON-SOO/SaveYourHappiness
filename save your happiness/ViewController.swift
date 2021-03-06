//
//  ViewController.swift
//  save your happiness
//
//  Created by 진윤수 on 2022/01/03.
//
// 처음 설정한 유리병과 메모지를 기본으로 내 설정에 넣어야함 -> 유저 뭐시기에 넣어야한다는 소리
import UIKit

class ViewController: UIViewController {
    
    lazy var slideInMenuPadding: CGFloat = self.view.frame.width * 0.40
    var isSlideInMenuPresented = false
    
    let menuList = ["로그인", "나의 창고", "설정"]
    let menuImage = [UIImage(named: "login_16.png"), UIImage(named: "home_16.png"), UIImage(named: "setting_16.png")]
    
    // 상단에 현재 날짜 시간 넣기
    // viewController에서 함수 호출하려면 클래스 정의한 후에 객체 선언 -> 함수 호출
    let DateView: UITextView = {
        let dateView = UITextView()
        dateView.translatesAutoresizingMaskIntoConstraints = false
        let now = GetDate()
        dateView.text = now.getNowTime()
        dateView.font = .systemFont(ofSize: 20)
        dateView.textColor = .black
        dateView.backgroundColor = UIColor.white.withAlphaComponent(0)
        dateView.isEditable = false
        dateView.isSelectable = false
        dateView.isScrollEnabled = false
        return dateView
    }()
    
    let CoinView: UIImageView = {
       let coinView = UIImageView()
        coinView.translatesAutoresizingMaskIntoConstraints = false
        coinView.image = UIImage(named: "coin.png")
        coinView.contentMode = .scaleAspectFit
        return coinView
    }()
    
    let CoinLabel:UILabel = {
        let coinLabel = UILabel()
        coinLabel.translatesAutoresizingMaskIntoConstraints = false
        coinLabel.font = .systemFont(ofSize: 15)
        coinLabel.text = String(UserDefaults.standard.integer(forKey: "mycoin"))
        coinLabel.textColor = .black
        coinLabel.backgroundColor = UIColor.white.withAlphaComponent(0)
        return coinLabel
    }()
    /* 상점페이지에서 연결하도록 변경
    let SettingButton: UIButton = {
        let settingButton = UIButton()
        settingButton.translatesAutoresizingMaskIntoConstraints = false
        settingButton.setImage(UIImage(named: "setting.png"), for: .normal)
        settingButton.imageView?.contentMode = .scaleAspectFit
        //settingButton.backgroundColor = .black
        settingButton.addTarget(self, action: #selector(settingButtonTouch), for: .touchUpInside)
        return settingButton
    }()
    
    @objc func settingButtonTouch(_sender:UIButton){
        let settingViewController = SettingViewController()
        settingViewController.modalPresentationStyle = .fullScreen
        present(settingViewController, animated: true, completion: nil)
    }
    */
    // 병 이미지 추가
    let JarImageView: UIImageView = {
        let baseImageView = UIImageView()
        // 이미지 뷰의 배경색 설정
        baseImageView.backgroundColor = UIColor.white.withAlphaComponent(0)
        //이미지 크기 조절
        //let jarImage = UIImage(named: "jar.png")
        // 디바이스 가로 세로 구하기
        //let bounds : CGRect = UIScreen.main.bounds
        //let jarImageRect = CGRect(x: 0, y: 0, width: 300, height: 450)
        //UIGraphicsBeginImageContext(CGSize(width: 300, height: 500))
        //jarImage?.draw(in: jarImageRect)
        //let jar = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(.alwaysOriginal)
        //UIGraphicsEndImageContext()
        // 이미지 파일과 연결
        //baseImageView.image = jar
        //baseImageView.image = UIImage(named: UserDefaults.standard.string(forKey: "presentJarImage")!)
        // scaleToFill: UIImageview 사이즈에 이미지를 맞춤
        // scaleAspectFit: 원본 사진 비율 유지하는데 높이|너비 중 더 큰 값을 UIImageView 사이즈에 맞추고 나머지는 비율로 맞춤
        // scaleAspectFill: 원본 사진 비율 유지하는데 높이|너비 중 더 작은 값을 UIImageView 사이즈에 맞추고 나머지는 비율로 맞춤
        // Scale To Fill : 원본 비율 유지 X, 꽉찬 이미지
        // Aspect Fit : 원본 비율 유지
        // Aspect Fill : 비율 유지, 꽉찬 이미지, 잘려보일 수 있음
        // Center : 가운데 정렬, 원본 사이즈
        // Top : 상단 정렬, 원본 사이즈
        baseImageView.contentMode = .scaleAspectFit
        
        // 둥근 테두리
        //baseImageView.layer.cornerRadius = 150
        
        // 그림자
        //baseImageView.layer.shadowOffset = CGSize(width: 5, height: 5)
        //baseImageView.layer.shadowOpacity = 0.7
        //baseImageView.layer.shadowRadius = 5
        //baseImageView.layer.shadowColor = UIColor.gray.cgColor
        
        // 넘치는 영역 잘라내기
        //baseImageView.clipsToBounds = true
        
        //코드로 제약사항 추가해줄거기 때문에 false로 지정
        baseImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return baseImageView
    }()
    
    //plus button 추가
    let PlusButton: UIButton = {
        let plusButton = UIButton()
        //plusButton.setImage(UIImage(named: "plusbutton.png"), for: .normal)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        // touchUpInside: 터치한 컴포넌트에서 손을 뗐을 때
        // 눌렀을 때 이벤트 처리
        plusButton.setImage(UIImage(named: "edit_24.png"), for: .normal)
        plusButton.imageView?.contentMode = .scaleAspectFit
        plusButton.addTarget(self, action: #selector(plusButtonTouch), for: .touchUpInside)
        return plusButton
    }()
    
    // 플러스 버튼 눌렀을 때 이벤트 처리 함수
    @objc func plusButtonTouch(_sender: UIButton){
        let popUpViewController = PopUpViewController()
        popUpViewController.modalPresentationStyle = .fullScreen
        present(popUpViewController, animated: true, completion: nil)
        //viewWillAppear(true)
    }
    
    //Store button 추가
    let StoreButton: UIButton = {
        let storeButton = UIButton()
        //plusButton.setImage(UIImage(named: "plusbutton.png"), for: .normal)
        storeButton.translatesAutoresizingMaskIntoConstraints = false
        // touchUpInside: 터치한 컴포넌트에서 손을 뗐을 때
        // 눌렀을 때 이벤트 처리
        storeButton.setImage(UIImage(named: "store_24.png"), for: .normal)
        storeButton.imageView?.contentMode = .scaleAspectFit
        storeButton.addTarget(self, action: #selector(storeButtonTouch), for: .touchUpInside)
        return storeButton
    }()
    
    // 상점 페이지 연결
    @objc func storeButtonTouch(){
        let storeViewController = StoreViewController()
        storeViewController.modalPresentationStyle = .fullScreen
        present(storeViewController, animated: true, completion: nil)
    }
    // 유리병 안에 메모지 버튼
    let MemoPaperButton: UIButton = {
        let memoPaperButton = UIButton()
        //memoPaperButton.setImage(UIImage(named:UserDefaults.standard.string(forKey: "presentMemoImage")!), for: .normal)
        memoPaperButton.imageView?.contentMode = .scaleAspectFit
        //memoPaperButton.backgroundColor = .black
        //memoPaperButton.imageView?.clipsToBounds = false
        memoPaperButton.translatesAutoresizingMaskIntoConstraints = false
        memoPaperButton.addTarget(self, action: #selector(memoPaperButtonTouch), for: .touchUpInside)
        return memoPaperButton
    }()
    
    @objc func memoPaperButtonTouch(_sender: UIButton){
        let memoListViewController = MemoListViewController()
        memoListViewController.modalPresentationStyle = .automatic
        present(memoListViewController, animated:  true, completion:  nil)
    }
    
    //메뉴버튼
    let StatisticsButton: UIButton = {
        let statisticsButton = UIButton()
        statisticsButton.translatesAutoresizingMaskIntoConstraints = false
        statisticsButton.setImage(UIImage(named: "histogram_24.png"), for: .normal)
        statisticsButton.imageView?.contentMode = .scaleAspectFit
        statisticsButton.addTarget(self, action: #selector(statisticsButtonTouch), for: .touchUpInside)
        return statisticsButton
        
    }()
    
    @objc func statisticsButtonTouch(_Sender: UIButton){
        let statisticsViewController = StatisticsViewController()
        statisticsViewController.modalPresentationStyle = .fullScreen
        // 하단에서 올라와라
        //menuViewController.modalTransitionStyle = .coverVertical
        present(statisticsViewController, animated : true, completion : nil)
    }
    
    let MenuButton: UIButton = {
           let menuButton = UIButton()
            menuButton.translatesAutoresizingMaskIntoConstraints = false
            menuButton.setImage(UIImage(named: "list_menu.png"), for: .normal)
            menuButton.imageView?.contentMode = .scaleAspectFit
            menuButton.addTarget(self, action: #selector(menuButtonTouch), for: .touchUpInside)
            return menuButton
        }()
        
    lazy var MenuView: UIView = {
        let menuView = UIView()
        menuView.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        return menuView
    }()
    
    lazy var MenuTableView: UITableView = {
        let menuTableView = UITableView()
        menuTableView.translatesAutoresizingMaskIntoConstraints = false
        menuTableView.backgroundColor = UIColor.clear
        menuTableView.separatorStyle = .none
        return menuTableView
    }()
        
    lazy var ContainerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        return containerView
    }()
    
    @objc func menuButtonTouch(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut){
            self.ContainerView.frame.origin.x = self.isSlideInMenuPresented ? 0 : self.ContainerView.frame.width - self.slideInMenuPadding
        } completion: { (finished) in
            // toggle() : bool 값을 반전
            self.isSlideInMenuPresented.toggle()
            if self.isSlideInMenuPresented == true{
                self.MemoPaperButton.isUserInteractionEnabled = false
                self.StatisticsButton.isUserInteractionEnabled = false
            } else {
                self.MemoPaperButton.isUserInteractionEnabled = true
                self.StatisticsButton.isUserInteractionEnabled = true
            }
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if self.isSlideInMenuPresented == true{
            menuButtonTouch()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        CoinLabel.text = String(UserDefaults.standard.integer(forKey: "mycoin"))
        JarImageView.image = UIImage(named: UserDefaults.standard.string(forKey: "presentJarImage")!)
        MemoPaperButton.setImage(UIImage(named:UserDefaults.standard.string(forKey: "presentMemoImage")!), for: .normal)
    }
    
    // viewDidLoad: 뷰의 로딩이 완료 되었을 때 시스템에 의해 자동으로 호출 => 초기화면 구성에 자주 쓰임
    override func viewDidLoad() {
        super.viewDidLoad()
        // 앱 처음 실행시 UserDefaults 초기 설정
        if FirstLanch.isFirstTime() == true{
            UserDefaults.standard.set("Cafe24-Ohsquareair", forKey: "myFont")
            UserDefaults.standard.set(false, forKey: "lockState")
            UserDefaults.standard.set([-1, -1, -1, -1], forKey: "passcode")
            UserDefaults.standard.set(0, forKey: "myCoin")
            UserDefaults.standard.set(["jar.png", "memostack_ver1.png"], forKey: "myItemImage")
            UserDefaults.standard.set("jar.png", forKey: "presentJarImage")
            UserDefaults.standard.set("memostack_ver1.png", forKey: "presentMemoImage")
        }

        // 자식 뷰 추가
        //view.backgroundColor = UIColor(displayP3Red: 218/255, green: 218/255, blue: 218/255, alpha: 1.0)
        MenuView.pinMenuTo(view, with: slideInMenuPadding)
        ContainerView.edgeTo(view)

        view.backgroundColor = .white
        ContainerView.addSubview(JarImageView)
        ContainerView.addSubview(MemoPaperButton)
        ContainerView.addSubview(DateView)
        ContainerView.addSubview(StatisticsButton)
        ContainerView.addSubview(PlusButton)
        ContainerView.addSubview(StoreButton)
        ContainerView.addSubview(CoinView)
        ContainerView.addSubview(CoinLabel)
        ContainerView.addSubview(MenuButton)
        
        MenuView.addSubview(MenuTableView)
        
        MenuTableView.delegate = self
        MenuTableView.dataSource = self
        MenuTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MenuTableViewCell")
   
        NSLayoutConstraint.activate([
            // 수직 제약 - 한가운데
            JarImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            // 수평 제약 - 한가운데
            JarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            // 최상위 레이아웃 가이드의 하단과 매칭 + 8만큼 아래로 내려라
            //JarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            // 하단에서 200만큼 띄워라
            //JarImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200),
            // ImageView의 왼쪽과 view의 왼쪽(leading)을 일치시킴
            JarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            // ImageView의 오른쪽과 view의 오른쪽(trailing)을 일치시킴
            JarImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // 너비 제약
            //ImageView.widthAnchor.constraint(equalTo:view.widthAnchor, multiplier: 1.0),
            //높이 제약
            //ImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0)
            DateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            DateView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 43),
            //StoreButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: UIScreen.main.bounds.width/0.5),
            //SettingButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300),
            //DateView.bottomAnchor.constraint(equalTo: JarImageView.topAnchor),
            MenuButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            MenuButton.trailingAnchor.constraint(equalTo: DateView.leadingAnchor, constant: -35),
            MenuButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),

            CoinView.leadingAnchor.constraint(equalTo: DateView.trailingAnchor, constant: 10),
            CoinView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13),
            CoinView.bottomAnchor.constraint(equalTo: DateView.bottomAnchor, constant: 20),
            CoinView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            CoinLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13),
            CoinLabel.leadingAnchor.constraint(equalTo: CoinView.trailingAnchor, constant: 5),
            CoinLabel.bottomAnchor.constraint(equalTo: CoinView.bottomAnchor),
            
            PlusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            // 다른 뷰의 높이 중심점에서 40 올린 위치를 높이로 지정
            PlusButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            StatisticsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            // 다른 뷰의 높이 중심점에서 40 올린 위치를 높이로 지정
            StatisticsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),

            StoreButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            StoreButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            MemoPaperButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //MemoPaperButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            MemoPaperButton.bottomAnchor.constraint(equalTo: PlusButton.topAnchor, constant: -50),
            MemoPaperButton.topAnchor.constraint(equalTo: JarImageView.topAnchor, constant: 300),
            MemoPaperButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            MemoPaperButton.trailingAnchor.constraint(equalTo: JarImageView.trailingAnchor, constant: -100),
            MenuTableView.topAnchor.constraint(equalTo: MenuView.topAnchor, constant: 90),
            MenuTableView.leadingAnchor.constraint(equalTo: MenuView.leadingAnchor),
            MenuTableView.trailingAnchor.constraint(equalTo: MenuView.trailingAnchor),
            MenuTableView.bottomAnchor.constraint(equalTo: MenuView.bottomAnchor)
            
        ])
    // viewWillAppear: 다른 뷰에 갔다가 다시 돌아오는 상황
    // viewDidAppear: 뷰가 나타났다는 것을 컨트롤러에게 알림, 뷰가 화면에 나타난 직후에 실행
    // viewWillDisappear: 뷰가 사라지기 직전에 호출되는 함수, 뷰가 삭제되려고 하고 있는 것을 뷰 컨트롤러에 알림
    // viewDidDisappear: 뷰 컨트롤러가 뷰가 제거되었다는 것을 알림
    
    }
}

public extension UIView {
    func edgeTo(_ view: UIView){
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func pinMenuTo(_ view: UIView, with constant: CGFloat){
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
extension ViewController: UITableViewDelegate{

}

extension ViewController: UITableViewDataSource{
    
    func loginButtonTouch(){
        let loginViewController = LoginViewController()
        loginViewController.modalPresentationStyle = .fullScreen
        //loginViewController.modalTransitionStyle = .crossDissolve
        present(loginViewController, animated : false, completion : nil)
    }
    
    func settingButtonTouch(){
        let changeSettingController = ChangeSettingController()
        changeSettingController.modalPresentationStyle = .fullScreen
        //changeSettingController.modalTransitionStyle = .crossDissolve
        present(changeSettingController, animated : false, completion : nil)
    }
    
    func storageButtonTouch(){
        let settingViewController = SettingViewController()
        settingViewController.modalPresentationStyle = .fullScreen
        present(settingViewController, animated: false, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = UITableViewCell()
        cell.imageView?.image = menuImage[indexPath.row]
        cell.textLabel?.text = menuList[indexPath.row]
        cell.textLabel?.font = .systemFont(ofSize: 15)
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            loginButtonTouch()
        case 1:
            storageButtonTouch()
        case 2:
            settingButtonTouch()
        default:
            print("no")
            
        }
    }
}
