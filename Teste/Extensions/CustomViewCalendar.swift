//
//  CalendarView.swift
//  Bravve
//
//  Created by Evandro Rodrigo Minamoto on 18/08/22.
//

import UIKit

enum MyTheme {
    case light
    case dark
}

struct Colors {
    
    static var darkGray = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
    static var darkRed = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
}

struct Style {
    
    static var bgColor = UIColor.black
    static var monthViewLblColor = UIColor.black
    static var monthViewBtnRightColor = UIColor.black
    static var monthViewBtnLeftColor = UIColor.black
    static var activeCellLblColor = UIColor.white
    static var activeCellLblColorHighlighted = UIColor.black
    static var weekdaysLblColor = UIColor.black
    
    static func themeDark(){
        
        bgColor = Colors.darkGray
        monthViewLblColor = UIColor.white
        monthViewBtnRightColor = UIColor.white
        monthViewBtnLeftColor = UIColor.white
        activeCellLblColor = UIColor.white
        activeCellLblColorHighlighted = UIColor.black
        weekdaysLblColor = UIColor.white
    }
    
    static func themeLight(){
        
        bgColor = UIColor.white
        monthViewLblColor = UIColor.black
        monthViewBtnRightColor = UIColor.black
        monthViewBtnLeftColor = UIColor.black
        activeCellLblColor = UIColor.black
        activeCellLblColorHighlighted = UIColor.white
        weekdaysLblColor = UIColor.black
    }
}

class CalendarView: UIView, CalendarMonthViewDelegate {
    
    private var numOfDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    private var currentMonthIndex: Int = 0
    private var currentYear: Int = 0
    private var presentMonthIndex = 0
    private var presentYear = 0
    private var todaysDate = 0
    private var firstWeekDayOfMonth = 0   //(Sunday-Saturday 1-7)
    
    var delegate: CalendarViewProtocol?
    
    private let monthView: CalendarMonthView = {
        
        let calendarMonthView = CalendarMonthView()
        calendarMonthView.translatesAutoresizingMaskIntoConstraints = false
        
        return calendarMonthView
    }()
    
    private let weekdaysView: CalendarWeekdaysView = {
        
        let calendarWeekdaysView = CalendarWeekdaysView()
        calendarWeekdaysView.translatesAutoresizingMaskIntoConstraints = false
        
        return calendarWeekdaysView
    }()
    
    let myCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let myCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        myCollectionView.showsHorizontalScrollIndicator = false
        myCollectionView.translatesAutoresizingMaskIntoConstraints=false
        myCollectionView.backgroundColor = .clear
        myCollectionView.allowsMultipleSelection = false
        return myCollectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(theme: MyTheme) {
        self.init()
        
        if theme == .dark {
            
            Style.themeDark()
        }
        else {
            
            Style.themeLight()
        }
        
        initializeView()
    }
    
    func changeTheme() {
        
        myCollectionView.reloadData()
        
        monthView.lblName.textColor = Style.monthViewLblColor
        monthView.buttonRight.setTitleColor(Style.monthViewBtnRightColor, for: .normal)
        monthView.buttonLeft.setTitleColor(Style.monthViewBtnLeftColor, for: .normal)
        
        for i in 0..<7 {
            
            (weekdaysView.myStackView.subviews[i] as! UILabel).textColor = Style.weekdaysLblColor
        }
    }
    
    private func initializeView() {
        
        currentMonthIndex = Calendar.current.component(.month, from: Date())
        currentYear = Calendar.current.component(.year, from: Date())
        todaysDate = Calendar.current.component(.day, from: Date())
        firstWeekDayOfMonth=getFirstWeekDay()
        
        //for leap years, make february month of 29 days
        if currentMonthIndex == 2 && currentYear % 4 == 0 {
            numOfDaysInMonth[currentMonthIndex-1] = 29
        }
        //end
            
        presentMonthIndex=currentMonthIndex
        presentYear=currentYear
        
        setupViews()
        
        myCollectionView.delegate=self
        myCollectionView.dataSource=self
        myCollectionView.register(dateCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    private func setupViews() {
        
        addSubview(monthView)
        
        monthView.topAnchor.constraint(equalTo: topAnchor).isActive=true
        monthView.leftAnchor.constraint(equalTo: leftAnchor, constant: 30).isActive=true
        monthView.rightAnchor.constraint(equalTo: rightAnchor, constant:  -30).isActive=true
        monthView.heightAnchor.constraint(equalToConstant: 70).isActive=true
        monthView.delegate = self
        
        addSubview(weekdaysView)
        
        weekdaysView.topAnchor.constraint(equalTo: monthView.bottomAnchor).isActive=true
        weekdaysView.centerXAnchor.constraint(equalTo: monthView.centerXAnchor).isActive = true
        weekdaysView.widthAnchor.constraint(equalToConstant: 280).isActive = true
        
        addSubview(myCollectionView)
        
        myCollectionView.topAnchor.constraint(equalTo: weekdaysView.bottomAnchor, constant: 10).isActive = true
        myCollectionView.centerXAnchor.constraint(equalTo: weekdaysView.centerXAnchor).isActive = true
        myCollectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        myCollectionView.widthAnchor.constraint(equalToConstant: 280).isActive = true
    }
    
    private func getFirstWeekDay() -> Int {
        
        let day = ("\(currentYear)-\(currentMonthIndex)-01".date?.firstDayOfTheMonth.weekday)!      //1-7 -> Sun-Sat
        return day == 1 ? 8 : day
    }
    
    func didChangeMonth(monthIndex: Int, year: Int) {
        
        currentMonthIndex = monthIndex+1
        currentYear = year
        
        //for leap year, make february month of 29 days
        if monthIndex == 1 {
            
            if currentYear % 4 == 0 {
                
                numOfDaysInMonth[monthIndex] = 29
            } else {
                numOfDaysInMonth[monthIndex] = 28
            }
        }
        //end
        
        firstWeekDayOfMonth = getFirstWeekDay()
        
        myCollectionView.reloadData()
        
        monthView.buttonLeft.isEnabled = !(currentMonthIndex == presentMonthIndex && currentYear == presentYear)
    }
}

extension CalendarView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let numDays = numOfDaysInMonth[currentMonthIndex-1]
        let num = numDays + firstWeekDayOfMonth - 2
        return num
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
       let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! dateCollectionViewCell
        
       cell.backgroundColor = UIColor.clear
       if indexPath.item <= firstWeekDayOfMonth - 3 {
           cell.isHidden = true
       }
        else {
            
           let calcDate = indexPath.row - firstWeekDayOfMonth+3
           cell.isHidden = false
           cell.label.text = "\(calcDate)"
           if calcDate < todaysDate && currentYear == presentYear && currentMonthIndex == presentMonthIndex {
               
               cell.isUserInteractionEnabled = false
               cell.label.textColor = UIColor.lightGray
            }
            else {
                
                cell.isUserInteractionEnabled = true
                cell.label.textColor = UIColor(named: ColorsBravve.blue.rawValue)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as? dateCollectionViewCell
        
        if cell?.backgroundColor == .clear {
            
            cell?.backgroundColor = UIColor(named: ColorsBravve.blue.rawValue)
            cell?.label.textColor = .white
            delegate?.chosedDays(cell?.label.text ?? "",
                                 "\(currentMonthIndex)",
                                 "\(currentYear)")
        }
        else {
            
            cell?.backgroundColor = .clear
            cell?.label.textColor = UIColor(named: ColorsBravve.blue.rawValue)
            delegate?.unchoseDays(cell?.label.text ?? "",
                                  "\(currentMonthIndex)",
                                  "\(currentYear)")
        }
    }
}

extension CalendarView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = 40
        let height: CGFloat = 40
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
}

class dateCollectionViewCell: UICollectionViewCell {
    
    let label: UILabel = {
        
        let label = UILabel()
        label.text = "00"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = Colors.darkGray
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints=false
        return label
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        layer.cornerRadius = frame.size.height/2
        layer.masksToBounds = true
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        addSubview(label)
        label.topAnchor.constraint(equalTo: topAnchor).isActive=true
        label.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
        label.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive=true
    }
}

//get first day of the month
extension Date {
    
    var weekday: Int {
        
        return Calendar.current.component(.weekday, from: self)
    }
    var firstDayOfTheMonth: Date {
        
        return Calendar.current.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
    }
}

//get date from string
extension String {
    
    static var dateFormatter: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter
    }()
    
    var date: Date? {
        
        return String.dateFormatter.date(from: self)
    }
}

protocol CalendarViewProtocol {
    
    func chosedDays(_ day: String,_ month: String,_ year: String)
    
    func unchoseDays(_ day: String,_ month: String,_ year: String)
}