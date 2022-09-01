//
//  Reservas2.swift
//  Bravve
//
//  Created by user208023 on 8/4/22.
//

import UIKit

class Reservation2View: UIViewController {
   

    //MARK: - preferredStatusBarStyle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    //MARK: - var and let
    private lazy var tabBar = TabBarClosed(self)

    
    //MARK: - tableview
    private let tableview: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = UIColor(named: ColorsBravve.background.rawValue)
        table.bounces = true
        table.translatesAutoresizingMaskIntoConstraints = false
       return table
    }()
    
    

    //MARK: - buttons
    private lazy var buttons: [UIButton] = {
        
        let buttons = createProgressBarButtonsWithoutActions([IconsBravve.walletGray.rawValue, IconsBravve.calendarGray.rawValue, IconsBravve.pencilBlue.rawValue, IconsBravve.creditGray.rawValue])
        
        buttons[2].setTitle("Revisão", for: .normal)
        
        let doubleDismissHandler = {(action: UIAction) in
            
            if let singleBooking = self.presentingViewController,
               let workPassBooking = singleBooking.presentingViewController {
                
                singleBooking.view.isHidden = true
                workPassBooking.dismiss(animated: false)
            }
        }
        
        let dismissHandler = {(action: UIAction) in
            
            self.dismiss(animated: false)
        }
        
        buttons[0].addAction(UIAction(handler: doubleDismissHandler), for: .touchUpInside)
        buttons[1].addAction(UIAction(handler: dismissHandler), for: .touchUpInside)
        
        return buttons
    }()

    
    //MARK: - confirmReservationButton
    private let confirmReservationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Confirmar Reserva", for: .normal)
        button.backgroundColor = UIColor(named: ColorsBravve.buttonPink.rawValue)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont(name: FontsBravve.bold.rawValue, size: CGFloat(16).generateSizeForScreen)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    //MARK: - loadView
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor(named: ColorsBravve.background.rawValue)
        view.addSubviews([tableview,
                          confirmReservationButton,
                          tabBar])
        
        
        tableview.register(LocationDetailsBookingReviewCustomCell.self, forCellReuseIdentifier: LocationDetailsBookingReviewCustomCell.reuseIdLocation)
        
        tableview.register(SummaryBookingReviewCustomCell.self, forCellReuseIdentifier: SummaryBookingReviewCustomCell.reuseIdSummary)
        
        tableview.register(DataBookingDayFirstCell.self, forCellReuseIdentifier: DataBookingDayFirstCell.reuseIdDataBookingDayFirst)
        
        tableview.register(DataBookingDaySecondCell.self, forCellReuseIdentifier: DataBookingDaySecondCell.reuseIdDataBookingDaySecond)
        
        tableview.register(DataBookingDayThirdCell.self, forCellReuseIdentifier: DataBookingDayThirdCell.reuseIdDataBookingDayThird)
        
        tableview.register(TotalPayableBookingReviewCustomCell.self, forCellReuseIdentifier: TotalPayableBookingReviewCustomCell.reuseIdPayable)
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.addSubviews([
                                     
                                    ])
        
        setupConstrains()
        tabBar.selectedItem = tabBar.items?[0]
        
        view.createReservationCustomBar (progressBarButtons: buttons) { _ in
            self.dismiss(animated: true)
        }
        
        
        confirmReservationButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        

    }
    
    private func setupConstrains() {
        
        NSLayoutConstraint.activate([
            
            //MARK: - tableview Consrtaints
            tableview.topAnchor.constraint(equalTo: view.topAnchor, constant: 210),
            tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableview.bottomAnchor.constraint(equalTo: confirmReservationButton.topAnchor),
            
            
            //MARK: - confirmReservationButton Consrtaints
            confirmReservationButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            confirmReservationButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            confirmReservationButton.bottomAnchor.constraint(equalTo: tabBar.topAnchor),
            confirmReservationButton.heightAnchor.constraint(equalToConstant: CGFloat(52).generateSizeForScreen)
            
        ])
        
        //MARK: - tabBar Consrtaints
        tabBar.constraintInsideTo(.leading, view.safeAreaLayoutGuide)
        tabBar.constraintInsideTo(.trailing, view.safeAreaLayoutGuide)
        tabBar.constraintInsideTo(.bottom, view.safeAreaLayoutGuide)
        
        
    }
    
    //MARK: - confirmButtonTapped
    @objc func confirmButtonTapped(){
        let reserveViewController = ReservationsThreeViewController()
        reserveViewController.modalPresentationStyle = .fullScreen
        present(reserveViewController, animated: true)
    }
    
}


//MARK: - config tableView
extension Reservation2View: UITableViewDelegate, UITableViewDataSource {

    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }

    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cellLocation = tableview.dequeueReusableCell(withIdentifier: LocationDetailsBookingReviewCustomCell.reuseIdLocation, for: indexPath) as?
                    LocationDetailsBookingReviewCustomCell else {
                return UITableViewCell()
            }
            return cellLocation
        case 1:
            guard let cellSummary = tableview.dequeueReusableCell(withIdentifier: SummaryBookingReviewCustomCell.reuseIdSummary, for: indexPath) as?
                    SummaryBookingReviewCustomCell else {
                return UITableViewCell()
            }
            cellSummary.sumaryProtocol = self
            return cellSummary
        case 2:
            guard let cellDataDayFirst = tableview.dequeueReusableCell(withIdentifier: DataBookingDayFirstCell.reuseIdDataBookingDayFirst, for: indexPath) as?
                    DataBookingDayFirstCell else {
                return UITableViewCell()
            }
            return cellDataDayFirst
        case 3:
            guard let cellDataDaySecond = tableview.dequeueReusableCell(withIdentifier: DataBookingDaySecondCell.reuseIdDataBookingDaySecond, for: indexPath) as?
                    DataBookingDaySecondCell else {
                return UITableViewCell()
            }
            return cellDataDaySecond
        case 4:
            guard let cellDataDaySecond = tableview.dequeueReusableCell(withIdentifier: DataBookingDayThirdCell.reuseIdDataBookingDayThird, for: indexPath) as?
                    DataBookingDayThirdCell else {
                return UITableViewCell()
            }
            return cellDataDaySecond
        default:
            guard let cellValueTotal = tableview.dequeueReusableCell(withIdentifier: TotalPayableBookingReviewCustomCell.reuseIdPayable, for: indexPath) as?
                    TotalPayableBookingReviewCustomCell else {
                return UITableViewCell()
            }
            return cellValueTotal
        }
        
        
        
    
        



}
}
extension Reservation2View:SummaryBookingProtocol{
    func setButtonTapped(sender: UIButton) {
        self.dismiss(animated: true)
    }
}
