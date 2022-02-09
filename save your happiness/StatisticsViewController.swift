//
//  StatisticsViewController.swift
//  save your happiness
//
//  Created by 진윤수 on 2022/01/20.
//

import UIKit
import Charts

//UIScreen.main.bounds.size.width
class StatisticsViewController: UIViewController{
    var todayMemonum : String = "0"
    
    var weekMemo : [Int] = []
    var maxDayIndex : Int = 0
    var WeekearnCoin : String = ""
    var WeekaverageMemoNum : String = ""
    
    var monthMemo : [Int] = []
    var maxMonthIndex : Int = 0
    var monthAvergeMemoNum : String = ""
    var monthIndex : Int = 0
    var monthEarnCoin : String = ""
    
    var yearMemo : [Int] = []
    var yearEarnCoin : String = ""
    
    var WeekDataX : [String]!
    var WeekDataEntries : [BarChartDataEntry] = []
    
    var MonthDataX : [String] = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
    var MonthDataEntries : [BarChartDataEntry] = []
    
    var YearDataX : [String] = []
    var YearDataEntries : [BarChartDataEntry] = []
    
    let TodayView: UIView = {
        let todayView = UIView()
        todayView.translatesAutoresizingMaskIntoConstraints = false
        todayView.backgroundColor = UIColor(displayP3Red: 249/255, green: 249/255, blue: 144/255, alpha: 1.0)
        //todayView.backgroundColor = .white
        return todayView
    }()
    
    let TodayLabel: UILabel = {
        let todayLabel = UILabel()
        todayLabel.translatesAutoresizingMaskIntoConstraints = false
        todayLabel.textColor = .black
        //todayLabel.text = "오늘의 행복 " + todayMemonum + "개"
        todayLabel.font = UIFont(name: "KCCMurukmuruk", size: 20)
        return todayLabel
    }()
    
    let StatisticsBackLabel : UILabel = {
        let statisticsBackLabel = UILabel()
        statisticsBackLabel.translatesAutoresizingMaskIntoConstraints = false
        statisticsBackLabel.textColor = .blue
        statisticsBackLabel.text = " ← 돌아가기"
        statisticsBackLabel.font = UIFont(name: "KCCMurukmuruk", size: 13)
        statisticsBackLabel.backgroundColor = UIColor.white.withAlphaComponent(0)
        return statisticsBackLabel
    }()
    
    let StatisticsBackButton : UIButton = {
        let statisticsBackButton = UIButton()
        statisticsBackButton.translatesAutoresizingMaskIntoConstraints = false
        statisticsBackButton.addTarget(self, action: #selector(statisticsBackButtonTouch), for: .touchUpInside)
        return statisticsBackButton
    }()
    
    @objc func statisticsBackButtonTouch(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    let StatisticsScrollView : UIScrollView = {
        let statisticsScrollView = UIScrollView()
        statisticsScrollView.translatesAutoresizingMaskIntoConstraints = false
        statisticsScrollView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        statisticsScrollView.backgroundColor = UIColor.white.withAlphaComponent(0)
        statisticsScrollView.alwaysBounceVertical = false
        statisticsScrollView.isPagingEnabled = true //스크롤 뷰에서 페이징 가능하도록 설정
        statisticsScrollView.isScrollEnabled = true
        statisticsScrollView.showsHorizontalScrollIndicator = false
        return statisticsScrollView
    }()
    
    var StatisticsPageViewControl : UIPageControl = {
        var statisticsPageViewControl = UIPageControl()
        statisticsPageViewControl.numberOfPages = 3
        statisticsPageViewControl.currentPage = 0
        //statisticsPageViewControl.pageIndicatorTintColor = .clear
        //statisticsPageViewControl.currentPageIndicatorTintColor = .white
        return statisticsPageViewControl
    }()
    
    let WeekView : UIView = {
        let weekView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        weekView.backgroundColor = UIColor(displayP3Red: 249/255, green: 249/255, blue: 144/255, alpha: 1.0)
        weekView.layer.cornerRadius = 20
        //weekView.layer.masksToBounds = true 뷰 밖에 있는건 안보이게 하겠ㅏ
        weekView.translatesAutoresizingMaskIntoConstraints = false
        /*
        weekView.layer.shadowColor = UIColor.darkGray.cgColor
        weekView.layer.shadowOpacity = 0.2
        weekView.layer.shadowRadius = 5*/
        return weekView
    }()
    
    let WeekHappyLabel : UILabel = {
        let weekHappyLabel = UILabel()
        weekHappyLabel.translatesAutoresizingMaskIntoConstraints = false
        weekHappyLabel.font = UIFont(name: "KCCMurukmuruk", size: 15)
        weekHappyLabel.textColor = .gray
        weekHappyLabel.textAlignment = .center
        weekHappyLabel.isUserInteractionEnabled = false
        return weekHappyLabel
    }()
    
    let WeekAverageMemo : UILabel = {
        let weekAverageMemo = UILabel()
        weekAverageMemo.translatesAutoresizingMaskIntoConstraints = false
        weekAverageMemo.font = UIFont(name: "KCCMurukmuruk", size: 15)
        weekAverageMemo.textColor = .gray
        weekAverageMemo.textAlignment = .center
        weekAverageMemo.isUserInteractionEnabled = false
        return weekAverageMemo
    }()
    
    let WeekEarnCoin : UILabel = {
        let weekEarnCoin = UILabel()
        weekEarnCoin.translatesAutoresizingMaskIntoConstraints = false
        weekEarnCoin.font = UIFont(name: "KCCMurukmuruk", size: 15)
        weekEarnCoin.textColor = .gray
        weekEarnCoin.textAlignment = .center
        weekEarnCoin.isUserInteractionEnabled = false
        return weekEarnCoin
    }()
    
    let WeekLastLabel : UILabel = {
        let weekLastLabel = UILabel()
        weekLastLabel.translatesAutoresizingMaskIntoConstraints = false
        weekLastLabel.font = UIFont(name: "KCCMurukmuruk", size: 15)
        weekLastLabel.textColor = .gray
        weekLastLabel.textAlignment = .center
        weekLastLabel.isUserInteractionEnabled = false
        weekLastLabel.text = "우린 더 행복한 한 주를 보낼꺼에요!"
        return weekLastLabel
    }()
    var WeekBarChartView : BarChartView = {
        var weekBarChartView = BarChartView()
        weekBarChartView.translatesAutoresizingMaskIntoConstraints = false
        weekBarChartView.layer.cornerRadius = 20
        weekBarChartView.layer.masksToBounds = true
        weekBarChartView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        weekBarChartView.backgroundColor = UIColor(displayP3Red: 218/255, green: 218/255, blue: 218/255, alpha: 1.0)
        weekBarChartView.animate(xAxisDuration: 0.5, yAxisDuration: 1.0)
        return weekBarChartView
    }()
    
    var MonthBarChartView : BarChartView = {
        var monthBarChartView = BarChartView()
        monthBarChartView.translatesAutoresizingMaskIntoConstraints = false
        monthBarChartView.layer.cornerRadius = 20
        monthBarChartView.layer.masksToBounds = true
        monthBarChartView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        monthBarChartView.backgroundColor = UIColor(displayP3Red: 218/255, green: 218/255, blue: 218/255, alpha: 1.0)
        //monthBarChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        return monthBarChartView
    }()
    
    let MonthView : UIView = {
        let monthView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        monthView.backgroundColor = UIColor(displayP3Red: 249/255, green: 249/255, blue: 144/255, alpha: 1.0)
        monthView.layer.cornerRadius = 20
        monthView.layer.masksToBounds = true
        monthView.translatesAutoresizingMaskIntoConstraints = false
        return monthView
    }()
    
    let MonthHappyLabel : UILabel = {
        let monthHappyLabel = UILabel()
        monthHappyLabel.translatesAutoresizingMaskIntoConstraints = false
        monthHappyLabel.font = UIFont(name: "KCCMurukmuruk", size: 15)
        monthHappyLabel.textColor = .gray
        monthHappyLabel.textAlignment = .center
        monthHappyLabel.isUserInteractionEnabled = false
        return monthHappyLabel
    }()
    
    let ThisMonthLabel : UILabel = {
        let thisMonthLabel = UILabel()
        thisMonthLabel.translatesAutoresizingMaskIntoConstraints = false
        thisMonthLabel.font = UIFont(name: "KCCMurukmuruk", size: 15)
        thisMonthLabel.textColor = .gray
        thisMonthLabel.textAlignment = .center
        thisMonthLabel.isUserInteractionEnabled = false
        return thisMonthLabel
    }()
    
    let MonthAverageMemo : UILabel = {
        let monthAverageMemo = UILabel()
        monthAverageMemo.translatesAutoresizingMaskIntoConstraints = false
        monthAverageMemo.font = UIFont(name: "KCCMurukmuruk", size: 15)
        monthAverageMemo.textColor = .gray
        monthAverageMemo.textAlignment = .center
        monthAverageMemo.isUserInteractionEnabled = false
        return monthAverageMemo
    }()
    
    let MonthEarnCoin : UILabel = {
        let monthEarnCoin = UILabel()
        monthEarnCoin.translatesAutoresizingMaskIntoConstraints = false
        monthEarnCoin.font = UIFont(name: "KCCMurukmuruk", size: 15)
        monthEarnCoin.textColor = .gray
        monthEarnCoin.textAlignment = .center
        monthEarnCoin.isUserInteractionEnabled = false
        return monthEarnCoin
    }()
    
    var YearBarChartView : BarChartView = {
        var yearBarChartView = BarChartView()
        yearBarChartView.translatesAutoresizingMaskIntoConstraints = false
        yearBarChartView.layer.cornerRadius = 20
        yearBarChartView.layer.masksToBounds = true
        yearBarChartView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        yearBarChartView.backgroundColor = UIColor(displayP3Red: 218/255, green: 218/255, blue: 218/255, alpha: 1.0)
        //yearBarChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
        return yearBarChartView
    }()
    
    let YearView : UIView = {
        let yearView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        yearView.backgroundColor = UIColor(displayP3Red: 249/255, green: 249/255, blue: 144/255, alpha: 1.0)
        yearView.layer.cornerRadius = 20
        yearView.layer.masksToBounds = true
        yearView.translatesAutoresizingMaskIntoConstraints = false
        return yearView
    }()
    
    let YearHappyLabel : UILabel = {
        let yearHappyLabel = UILabel()
        yearHappyLabel.translatesAutoresizingMaskIntoConstraints = false
        yearHappyLabel.font = UIFont(name: "KCCMurukmuruk", size: 15)
        yearHappyLabel.textColor = .gray
        yearHappyLabel.textAlignment = .center
        yearHappyLabel.isUserInteractionEnabled = false
        return yearHappyLabel
    }()
    
    let YearEarnCoin : UILabel = {
        let yearEarnCoin = UILabel()
        yearEarnCoin.translatesAutoresizingMaskIntoConstraints = false
        yearEarnCoin.font = UIFont(name: "KCCMurukmuruk", size: 15)
        yearEarnCoin.textColor = .gray
        yearEarnCoin.textAlignment = .center
        yearEarnCoin.isUserInteractionEnabled = false
        return yearEarnCoin
    }()
    
    let YearLastLabel : UILabel = {
        let yearLastLabel = UILabel()
        yearLastLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLastLabel.font = UIFont(name: "KCCMurukmuruk", size: 15)
        yearLastLabel.textColor = .gray
        yearLastLabel.textAlignment = .center
        yearLastLabel.isUserInteractionEnabled = false
        yearLastLabel.text = "우린 올해를 더 행복하게 보낼 수 있어요!"
        return yearLastLabel
    }()
    
    func setPageControlSelectedPage(currentPage:Int){
        StatisticsPageViewControl.currentPage = currentPage
    }
    
    /* 고차함수 - 다른 함수를 전달 인자로 받거나 함수의 실행 결과를 함수로 반환
     1. map - 데이터 변형
     ex1)배열.map{$0 * 2}
     
     ex2)배열.map({(number:Int)-> Int in
     
            return number * 2
        })
     둘이 같은 거임
     
     2. reduce - 데이터 합치기
     ex1) 배열.reduce(0){$0 + $1}
     ex2) 배열.reduce(0, {(first:Int, second:Int)-> Int in
        return first + second
     })
     
     3. filter - 데이터 추출
     ex1)배열.filter{$0.count == 3}
     ex2)배열.filter({(value:String)->Bool in
        return value.count == 3 // 글자수 3개인거 반환해라
        })
     둘이 같은 거임
     */
    func Sum(numbers: [Int]) -> Int {
        return numbers.reduce(0, +)
    }
    
    func average(numbers: [Int], x_num: Int) -> Int {
        return numbers.reduce(0, +) / x_num
    }
    
    func setWeek(){
        weekMemo = getWeekNum()
        WeekDataX = getDayName()
        if weekMemo.count != 0{
            for i in 0...weekMemo.count-1{
                if weekMemo == [0, 0, 0, 0, 0, 0, 0] {
                    maxDayIndex = -1
                } else if weekMemo[i] == weekMemo.max(){
                    maxDayIndex = i
                }
            }
        } else {
            weekMemo = [0, 0, 0, 0, 0, 0, 0]
            maxDayIndex = -1
        }
        
        //while문 case에다가 쓸 수 있음
        for i in 0...WeekDataX.count-1{
            switch WeekDataX[i]{
            case "Mon":
                WeekDataX[i] = "월"
            case "Tue":
                WeekDataX[i] = "화"
            case "Wed":
                WeekDataX[i] = "수"
            case "Thu":
                WeekDataX[i] = "목"
            case "Fri":
                WeekDataX[i] = "금"
            case "Sat":
                WeekDataX[i] = "토"
            case "Sun":
                WeekDataX[i] = "일"
            default:
                WeekDataX[i] = "월"
            }
        }
        
        WeekearnCoin = String(Sum(numbers: weekMemo) * 5)
        WeekaverageMemoNum = String(average(numbers: weekMemo, x_num: 7))
        
        for i in 0...6 {
            let dataEntry = BarChartDataEntry(x:Double(i), y: Double(weekMemo[i]))
            WeekDataEntries.append(dataEntry)
        }
        
        let numFormatter = NumberFormatter()
        numFormatter.numberStyle = .currency
        numFormatter.maximumFractionDigits = 0
        
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        let chartDataSet = BarChartDataSet(entries: WeekDataEntries)
        chartDataSet.colors = [.darkGray]
        chartDataSet.highlightEnabled = false
        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.setValueFormatter(formatter)
        WeekBarChartView.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: numFormatter)
        WeekBarChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: WeekDataX)
        WeekBarChartView.data = chartData
        
        let minLimitLine = ChartLimitLine(limit: 0)
        minLimitLine.lineColor = .darkGray
        WeekBarChartView.leftAxis.addLimitLine(minLimitLine)
        
        WeekBarChartView.rightAxis.enabled = false
        WeekBarChartView.doubleTapToZoomEnabled = false
        WeekBarChartView.xAxis.labelPosition = .bottom
        WeekBarChartView.xAxis.setLabelCount(7, force: false)
        WeekBarChartView.leftAxis.axisMinimum = 0
        WeekBarChartView.legend.enabled = false
        WeekBarChartView.xAxis.drawGridLinesEnabled = false
        WeekBarChartView.leftAxis.drawLabelsEnabled = false
    }
    
    func setMonth(){
        let today = Date()
        let Monthformatter = DateFormatter()
        Monthformatter.dateFormat = "MM월"
        monthMemo = getMonthNum()
        
        for i in 0...11 {
            let dataEntry = BarChartDataEntry(x:Double(i), y: Double(monthMemo[i]))
            MonthDataEntries.append(dataEntry)
        }
        
        for i in 0...monthMemo.count-1{
            if monthMemo == [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] {
                maxMonthIndex = -1
            } else if monthMemo[i] == monthMemo.max() {
                maxMonthIndex = i
            }
        }
        
        switch Monthformatter.string(from: today){
        case "01월":
            monthIndex = 1
        case "02월":
            monthIndex = 2
        case "03월":
            monthIndex = 3
        case "04월":
            monthIndex = 4
        case "05월":
            monthIndex = 5
        case "06월":
            monthIndex = 6
        case "07월":
            monthIndex = 7
        case "08월":
            monthIndex = 8
        case "09월":
            monthIndex = 9
        case "10월":
            monthIndex = 10
        case "11월":
            monthIndex = 11
        case "12월":
            monthIndex = 12
        default:
            monthIndex = 1
        }
        
        WeekaverageMemoNum = String(average(numbers: monthMemo, x_num: 12))
        monthEarnCoin = String(monthMemo[monthIndex-1] * 5)
        
        let numFormatter = NumberFormatter()
        numFormatter.numberStyle = .currency
        numFormatter.maximumFractionDigits = 0
        
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        let chartDataSet = BarChartDataSet(entries: MonthDataEntries)
        chartDataSet.colors = [.darkGray]
        chartDataSet.highlightEnabled = false
        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.setValueFormatter(formatter)
        MonthBarChartView.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: numFormatter)
        MonthBarChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: MonthDataX)
        MonthBarChartView.data = chartData
        
        let minLimitLine = ChartLimitLine(limit: 0)
        minLimitLine.lineColor = .darkGray
        MonthBarChartView.leftAxis.addLimitLine(minLimitLine)
        
        MonthBarChartView.rightAxis.enabled = false
        MonthBarChartView.doubleTapToZoomEnabled = false
        MonthBarChartView.xAxis.labelPosition = .bottom
        MonthBarChartView.xAxis.setLabelCount(12, force: false)
        MonthBarChartView.leftAxis.axisMinimum = 0
        MonthBarChartView.legend.enabled = false
        MonthBarChartView.xAxis.drawGridLinesEnabled = false
        MonthBarChartView.leftAxis.drawLabelsEnabled = false
    }
    
    func setYear(){
        let today = Date()
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "YYYY년"
        let interval : Double = 24 * 60 * 60 * 365
        let yearArray = [Date(timeInterval: -interval * 4, since: today),
                         Date(timeInterval: -interval * 3, since: today),
                         Date(timeInterval: -interval * 2, since: today),
                         Date(timeInterval: -interval, since: today),
                         today]
        
        for y in yearArray {
            YearDataX.append(yearFormatter.string(from: y))
        }
        
        yearMemo = getYearNum()
        
        for i in 0...4 {
            let dataEntry = BarChartDataEntry(x:Double(i), y: Double(yearMemo[i]))
            YearDataEntries.append(dataEntry)
        }
        
        yearEarnCoin = String(Sum(numbers: yearMemo) * 5)
        
        let numFormatter = NumberFormatter()
        numFormatter.numberStyle = .currency
        numFormatter.maximumFractionDigits = 0
        
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        let chartDataSet = BarChartDataSet(entries: YearDataEntries)
        chartDataSet.colors = [.darkGray]
        chartDataSet.highlightEnabled = false
        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.setValueFormatter(formatter)
        YearBarChartView.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: numFormatter)
        YearBarChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: YearDataX)
        YearBarChartView.data = chartData
        
        let minLimitLine = ChartLimitLine(limit: 0)
        minLimitLine.lineColor = .darkGray
        YearBarChartView.leftAxis.addLimitLine(minLimitLine)
        
        YearBarChartView.rightAxis.enabled = false
        YearBarChartView.doubleTapToZoomEnabled = false
        YearBarChartView.xAxis.labelPosition = .bottom
        YearBarChartView.xAxis.setLabelCount(5, force: false)
        YearBarChartView.leftAxis.axisMinimum = 0
        YearBarChartView.legend.enabled = false
        YearBarChartView.xAxis.drawGridLinesEnabled = false
        YearBarChartView.leftAxis.drawLabelsEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(TodayView)
        view.addSubview(TodayLabel)
        view.addSubview(StatisticsScrollView)
        view.addSubview(StatisticsPageViewControl)
        view.addSubview(StatisticsBackButton)
        view.addSubview(StatisticsBackLabel)
        
        dataBaseOpen()
        
        setWeek()
        TodayLabel.text = "오늘의 행복 " + getMyMemoNum() + "개"
        if maxDayIndex == -1 {
            WeekHappyLabel.text = "일주일 동안 행복을 담지 않았어요"
        } else {
            WeekHappyLabel.text = "일주일 동안 가장 행복했던 날은 " + WeekDataX[maxDayIndex] + "요일이네요"
        }
        WeekAverageMemo.text = "일주일 동안 평균적으로 " + WeekaverageMemoNum + "번 행복을 저금했어요"
        WeekEarnCoin.text = "한 주 동안 모은 코인은 " + WeekearnCoin + "개에요"
        
        setMonth()
        ThisMonthLabel.text = "이번 달은 총 " + String(monthMemo[monthIndex-1]) + "개의 행복을 담았어요"
        if maxMonthIndex == -1{
            MonthHappyLabel.text = "아직 행복을 기록한 달이 없어요"
        } else {
            MonthHappyLabel.text = "지금까지 " + MonthDataX[maxMonthIndex] + "이 가장 행복했어요"
        }
        
        MonthAverageMemo.text = "매달 평균적으로 " + WeekaverageMemoNum + "번 행복을 저금하고 있어요"
        MonthEarnCoin.text = "한 달동안 모은 코인은 " + monthEarnCoin + "개에요"
        
        setYear()
        YearHappyLabel.text = "이번 해는 총 " + String(yearMemo[4]) + "개의 행복을 담았네요"
        YearEarnCoin.text = "올해 모은 코인은 " + yearEarnCoin + "개에요"
        
        StatisticsScrollView.delegate = self
        
        for index in 0..<3 {
            let subView = UIView()
            let xPos = self.view.frame.width * CGFloat(index)
            subView.backgroundColor = UIColor.white.withAlphaComponent(0)
            subView.frame = CGRect(x: xPos, y: 0, width: StatisticsScrollView.bounds.width, height: StatisticsScrollView.bounds.height-50)
            StatisticsScrollView.addSubview(subView)
            if index == 0{
                subView.addSubview(WeekBarChartView)
                subView.addSubview(WeekView)
                WeekView.addSubview(WeekHappyLabel)
                WeekView.addSubview(WeekEarnCoin)
                WeekView.addSubview(WeekAverageMemo)
                WeekView.addSubview(WeekLastLabel)
                WeekBarChartView.topAnchor.constraint(equalTo: subView.topAnchor).isActive = true
                WeekBarChartView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -335).isActive = true
                WeekBarChartView.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 15).isActive = true
                WeekBarChartView.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: -15).isActive = true
                WeekView.topAnchor.constraint(equalTo: WeekBarChartView.bottomAnchor, constant: 30).isActive = true
                WeekView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
                WeekView.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 15).isActive = true
                WeekView.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: -15).isActive = true
                WeekHappyLabel.centerXAnchor.constraint(equalTo: WeekView.centerXAnchor).isActive = true
                WeekHappyLabel.topAnchor.constraint(equalTo: WeekView.topAnchor, constant: 20).isActive = true
                WeekAverageMemo.centerXAnchor.constraint(equalTo: WeekView.centerXAnchor).isActive = true
                WeekAverageMemo.topAnchor.constraint(equalTo: WeekHappyLabel.bottomAnchor, constant: 25).isActive = true
                WeekEarnCoin.centerXAnchor.constraint(equalTo: WeekView.centerXAnchor).isActive = true
                WeekEarnCoin.topAnchor.constraint(equalTo: WeekAverageMemo.bottomAnchor, constant: 25).isActive = true
                WeekLastLabel.centerXAnchor.constraint(equalTo: WeekView.centerXAnchor).isActive = true
                WeekLastLabel.topAnchor.constraint(equalTo: WeekEarnCoin.bottomAnchor, constant: 25).isActive = true
            } else if  index == 1 {
                subView.addSubview(MonthBarChartView)
                subView.addSubview(MonthView)
                MonthView.addSubview(MonthHappyLabel)
                MonthView.addSubview(ThisMonthLabel)
                MonthView.addSubview(MonthAverageMemo)
                MonthView.addSubview(MonthEarnCoin)
                MonthBarChartView.topAnchor.constraint(equalTo: subView.topAnchor).isActive = true
                MonthBarChartView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -335).isActive = true
                MonthBarChartView.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 15).isActive = true
                MonthBarChartView.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: -15).isActive = true
                MonthView.topAnchor.constraint(equalTo: MonthBarChartView.bottomAnchor, constant: 30).isActive = true
                MonthView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
                MonthView.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 15).isActive = true
                MonthView.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: -15).isActive = true
                MonthHappyLabel.centerXAnchor.constraint(equalTo: MonthView.centerXAnchor).isActive = true
                MonthHappyLabel.topAnchor.constraint(equalTo: MonthView.topAnchor, constant: 20).isActive = true
                ThisMonthLabel.centerXAnchor.constraint(equalTo: MonthView.centerXAnchor).isActive = true
                ThisMonthLabel.topAnchor.constraint(equalTo: MonthHappyLabel.bottomAnchor, constant: 25).isActive = true
                MonthAverageMemo.centerXAnchor.constraint(equalTo: MonthView.centerXAnchor).isActive = true
                MonthAverageMemo.topAnchor.constraint(equalTo: ThisMonthLabel.bottomAnchor, constant: 25).isActive = true
                MonthEarnCoin.centerXAnchor.constraint(equalTo: MonthView.centerXAnchor).isActive = true
                MonthEarnCoin.topAnchor.constraint(equalTo: MonthAverageMemo.bottomAnchor, constant: 25).isActive = true
            } else {
                subView.addSubview(YearBarChartView)
                subView.addSubview(YearView)
                YearView.addSubview(YearHappyLabel)
                YearView.addSubview(YearEarnCoin)
                YearView.addSubview(YearLastLabel)
                YearBarChartView.topAnchor.constraint(equalTo: subView.topAnchor).isActive = true
                YearBarChartView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -335).isActive = true
                YearBarChartView.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 15).isActive = true
                YearBarChartView.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: -15).isActive = true
                YearView.topAnchor.constraint(equalTo: YearBarChartView.bottomAnchor, constant: 30).isActive = true
                YearView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
                YearView.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 15).isActive = true
                YearView.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: -15).isActive = true
                YearHappyLabel.centerXAnchor.constraint(equalTo: YearView.centerXAnchor).isActive = true
                YearHappyLabel.topAnchor.constraint(equalTo: YearView.topAnchor, constant: 50).isActive = true
                YearEarnCoin.centerXAnchor.constraint(equalTo: YearView.centerXAnchor).isActive = true
                YearEarnCoin.topAnchor.constraint(equalTo: YearHappyLabel.bottomAnchor, constant: 25).isActive = true
                YearLastLabel.centerXAnchor.constraint(equalTo: YearView.centerXAnchor).isActive = true
                YearLastLabel.topAnchor.constraint(equalTo: YearEarnCoin.bottomAnchor, constant: 25).isActive = true
            }
            StatisticsScrollView.contentSize.width = subView.frame.width * CGFloat(index + 1)
        }
        
        view.backgroundColor =  UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha:1.0)
        
        NSLayoutConstraint.activate([
            TodayView.bottomAnchor.constraint(equalTo: StatisticsScrollView.topAnchor, constant: 80),
            TodayView.topAnchor.constraint(equalTo: view.topAnchor),
            TodayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            TodayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            TodayLabel.centerXAnchor.constraint(equalTo: TodayView.centerXAnchor),
            TodayLabel.centerYAnchor.constraint(equalTo: TodayView.centerYAnchor, constant: 10),
            StatisticsBackButton.leadingAnchor.constraint(equalTo: TodayView.leadingAnchor, constant: 30),
            StatisticsBackButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            StatisticsBackLabel.centerXAnchor.constraint(equalTo: StatisticsBackButton.centerXAnchor),
            StatisticsBackLabel.centerYAnchor.constraint(equalTo: StatisticsBackButton.centerYAnchor),
            StatisticsScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:  UIScreen.main.bounds.height/4),
            StatisticsScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            StatisticsScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            StatisticsScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
        ])
        
    }
    
}
extension StatisticsViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageNum = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        setPageControlSelectedPage(currentPage: Int(pageNum))
    }
}

func getMyMemoNum() -> String{
    let today = Date()
    let memodata = dataBaseSearch()
    var memoContent : [String] = []
    
    formatter.dateFormat = "yyyy년 MM월 dd일"
    
    if memodata.count == 0{
        return "0"
    } else {
        for i in 0...memodata.count-1{
            if memodata[i].Date.split(separator: "-")[0] == formatter.string(from:today){
                memoContent.append(memodata[i].Content)
             }
        }
    }
    return String(memoContent.count)
}
// 요일 이름 받아오기
func getDayName() -> [String] {
    let today = Date()
    let interval : Double = 24 * 60 * 60
    let weekDay : [Date] = [Date(timeInterval: -interval * 6, since: today),
                            Date(timeInterval: -interval * 5, since: today),
                            Date(timeInterval: -interval * 4, since: today),
                            Date(timeInterval: -interval * 3, since: today),
                            Date(timeInterval: -interval * 2, since: today),
                            Date(timeInterval: -interval, since: today),
                            today]
    var dayName : [String] = []
    var weekName : [String] = []
    
    formatter.dateFormat = "yyyy/M/d"
    for i in 0...weekDay.count-1{
        dayName.append(formatter.string(from: weekDay[i]))
    }
    
    for i in 0...dayName.count-1{
        let oneDay = dayName[i].components(separatedBy: "/").map({(value:String) -> Int in return Int(value)!})
        weekName.append(weekday(year: oneDay[0], month:oneDay[1], day:oneDay[2])!)
    }
    
    return weekName
}
// 한주 메모 개수 받아오기
func getWeekNum() -> [Int]{
    let today = Date()
    let interval : Double = 24 * 60 * 60
    let weekDay : [Date] = [Date(timeInterval: -interval * 6, since: today),
                            Date(timeInterval: -interval * 5, since: today),
                            Date(timeInterval: -interval * 4, since: today),
                            Date(timeInterval: -interval * 3, since: today),
                            Date(timeInterval: -interval * 2, since: today),
                            Date(timeInterval: -interval, since: today),
                            today]
    var weekMemoNum : [Int] = []
    let memodata = dataBaseSearch()
    var memoContent : [String] = []
    
    formatter.dateFormat = "yyyy년 MM월 dd일"
    
    for day in weekDay {
        memoContent = []
        if memodata.count != 0{
            for i in 0...memodata.count-1{
                        if memodata[i].Date.split(separator: "-")[0] == formatter.string(from:day){
                            memoContent.append(memodata[i].Content)
                            }
                        }
                    weekMemoNum.append(memoContent.count)
                }
        }
    return weekMemoNum
}

// 날짜 -> 요일 구하기
func weekday(year: Int, month: Int, day: Int) -> String? {
    
    let calendar = Calendar(identifier: .gregorian)
    
    guard let targetDate: Date = {
        let comps = DateComponents(calendar:calendar, year: year, month: month, day: day)
        return comps.date
        }() else { return nil }
    
    let day = Calendar.current.component(.weekday, from: targetDate) - 1
    
    return Calendar.current.shortWeekdaySymbols[day] // ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
}

func getMonthNum() -> [Int] {
    let today = Date()
    let monthArray = ["01월", "02월", "03월", "04월", "05월", "06월", "07월", "08월", "09월", "10월", "11월", "12월"]
    var monthMemoNum : [Int] = []
    var counting = 0
    let memodata = dataBaseSearch()
    
    
    formatter.dateFormat = "yyyy년"
    
    for m in monthArray {
        counting = 0
        if memodata.count != 0{
            for i in 0...memodata.count-1{
                if memodata[i].Date.split(separator: " ")[1] == m && memodata[i].Date.split(separator: " ")[0] == formatter.string(from:today){
                    counting += 1
                }
            }
            monthMemoNum.append(counting)
        } else {
            monthMemoNum = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        }
    }
    return monthMemoNum
}

func getYearNum() -> [Int] {
    let today = Date()
    let interval : Double = 24 * 60 * 60 * 365
    let yearArray = [Date(timeInterval: -interval * 4, since: today),
                     Date(timeInterval: -interval * 3, since: today),
                     Date(timeInterval: -interval * 2, since: today),
                     Date(timeInterval: -interval, since: today),
                     today]
    var yearMemoNum : [Int] = []
    var counting = 0
    let memodata = dataBaseSearch()
    
    formatter.dateFormat = "yyyy년"
    
    if memodata.count != 0 {
        for y in yearArray{
            for i in 0...memodata.count-1{
                    if memodata[i].Date.split(separator: " ")[0] == formatter.string(from:y){
                        counting += 1
                    }
                }
            yearMemoNum.append(counting)
        }
    } else {
        yearMemoNum = [0, 0, 0, 0, 0]
    }
    return yearMemoNum
}

