//
//  ReservaFinalizadaView.swift
//  Bravve
//
//  Created by user218260 on 7/15/22.
//


import UIKit

class ReservationCompletedView: UIViewController {
    
    //MARK: - text array
    private var spaceDetailArray = ["Aceita animais de estimação",
                                    "Impressoras empresariais",
                                    "Cafeteria",
                                    "Espaço ao ar livre",
                                    "Estacionamento",
                                    "Bicicletário",
                                    "Farmácia próxima", "Farmácia próxima", "Farmácia próxima", "Farmácia próxima", "Farmácia próxima", "Farmácia próxima", "Farmácia próxima", "Farmácia próxima", "Farmácia próxima", "Farmácia próxima"]
    
    //MARK: - variables to inherit values
    private var clientName = "Ana"
    private var locationAddress = "Av. São João, Cj. Boulevard, nº900, Sâo Paulo. SP 06020-010, BR"
    private var schedulingData = "Segunda: 08:00h - 17:00h"
    
    //MARK: - buttonReservation
    private let buttonReservation = UIButton()
    
    //MARK: - scrollView
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - labelsStack
    private lazy var labelsStack: UIStackView = {
        var views: [UIView] = []
            for element in spaceDetailArray {
                views.append(createLabel(placeHolderValue: element))
        }
        let labelsStack = UIStackView(arrangedSubviews:  views)
        labelsStack.axis = .vertical
        labelsStack.distribution = .fillEqually
        if views.count != 0 {
            views[0].heightAnchorInSuperview(30)
        }
        labelsStack.spacing = 1
        labelsStack.backgroundColor = .gray
        return labelsStack
    }()
    
    //MARK: - viewtoScroll
    private let viewToScroll: UIView = {
        let viewToScroll = UIView()
        return viewToScroll
    }()
    
   //MARK: - titleLabel
    private lazy var titleLabel: UILabel = {
         let titleLabel = UILabel()
         titleLabel.font = UIFont(name: "KoHo-Bold", size: CGFloat(45).generateSizeForScreen)
         titleLabel.textColor = .white
         titleLabel.text = "Parabéns, \(clientName)!"
         titleLabel.numberOfLines = 0
         titleLabel.translatesAutoresizingMaskIntoConstraints = false
         return titleLabel
     }()
    
     //MARK: - subtitleLabel
     private let subtitleLabel: UILabel = {
         let subtitleLabel = UILabel()
         subtitleLabel.font = UIFont(name: "Ubuntu-Regular", size: CGFloat(20).generateSizeForScreen)
         subtitleLabel.textColor = .white
         subtitleLabel.text = "Sua reserva foi realizada com \nsucesso!"
         subtitleLabel.numberOfLines = 0
         subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
         return subtitleLabel
     }()
    
     //MARK: - info1Label
     private let info1Label: UILabel = {
         let info1Label = UILabel()
         info1Label.font = UIFont(name: "Ubuntu-Regular", size: CGFloat(15).generateSizeForScreen)
         info1Label.textColor = .white
         info1Label.text = "Agradecemos por fazer sua reserva e abaixo, estamos mostrando o novo saldo da sua carteira e alguns detalhes sobre a sua reserva."
         info1Label.numberOfLines = 0
         info1Label.translatesAutoresizingMaskIntoConstraints = false
         return info1Label
     }()
    
    //MARK: - locationDetailLabel
    private let locationDetailLabel: UILabel = {
        let locationDetailLabel = UILabel()
        locationDetailLabel.font = UIFont(name: "Ubuntu-Bold", size: CGFloat(20).generateSizeForScreen)
        locationDetailLabel.textColor = .white
        locationDetailLabel.text = "Detalhe do local"
        locationDetailLabel.numberOfLines = 0
        locationDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        return locationDetailLabel
    }()
    
    //MARK: - locationLabel
    private lazy var locationLabel: UILabel = {
        let locationLabel = UILabel()
        locationLabel.font = UIFont(name: "Ubuntu-Regular", size: CGFloat(12).generateSizeForScreen)
        locationLabel.textColor = .white
        locationLabel.text = "\(locationAddress)"
        locationLabel.numberOfLines = 0
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        return locationLabel
    }()
    
    //MARK: - schedulingLabel
    private lazy var schedulingLabel: UILabel = {
        let schedulingLabel = UILabel()
        schedulingLabel.font = UIFont(name: "Ubuntu-Regular", size: CGFloat(12).generateSizeForScreen)
        schedulingLabel.textColor = .white
        schedulingLabel.text = "Sua reserva está marcada para \(schedulingData)"
        schedulingLabel.numberOfLines = 0
        schedulingLabel.translatesAutoresizingMaskIntoConstraints = false
        return schedulingLabel
    }()
    
    //MARK: - placeDetailLabel
    private let placeDetailLabel: UILabel = {
        let placeDetailLabel = UILabel()
        placeDetailLabel.font = UIFont(name: "Ubuntu-Bold", size: CGFloat(20).generateSizeForScreen)
        placeDetailLabel.textColor = .white
        placeDetailLabel.text = "Detalhe do espaço"
        placeDetailLabel.numberOfLines = 0
        placeDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        return placeDetailLabel
    }()
    
    //MARK: - locationIcon
    private let locationIcon: UIImageView = {
       let locationIcon = UIImageView(image: UIImage(named: "locationBlue"))
        locationIcon.translatesAutoresizingMaskIntoConstraints = false
        return locationIcon
    }()
    
    //MARK: - schedulingIcon
    private let schedulingIcon: UIImageView = {
        let schedulingIcon = UIImageView(image: UIImage(named: "clock"))
        schedulingIcon.translatesAutoresizingMaskIntoConstraints = false
        return schedulingIcon
    }()
    
    //MARK: - logoIcon
    private let logoIcon: UIImageView = {
        let logoIcon = UIImageView(image: UIImage(named: "logoWhite"))
        logoIcon.translatesAutoresizingMaskIntoConstraints = false
        return logoIcon
    }()
    
    //MARK: - waveIcon
    private let waveIcon: UIImageView = {
        let waveIcon = UIImageView(image: UIImage(named: "wayLogin"))
        waveIcon.translatesAutoresizingMaskIntoConstraints = false
        return waveIcon
    }()
    
    //MARK: - lineView
    private let lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .gray
        return lineView
    }()
    
    //MARK: - loadView
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: ColorsBravve.backgroundBravve.rawValue)
        view.addSubviews([logoIcon,
                          waveIcon,
                          buttonReservation,
                          scrollView])
        scrollView.addSubview(viewToScroll)
        viewToScroll.addSubviews([titleLabel,
                                  subtitleLabel,
                                  info1Label,
                                  locationDetailLabel,
                                  locationLabel,
                                  schedulingLabel,
                                  placeDetailLabel,
                                  lineView,
                                  locationIcon,
                                  schedulingIcon,
                                  labelsStack])
        self.buttonReservation.setToBottomButtonKeyboardDefault("Ir para Minhas Reservas", backgroundColor: .buttonPink)
        iconsConstraints()
        viewsConstraints()
        viewElementsConstraints()
        
        buttonReservation.addTarget(self, action: #selector(tapButtonReservation), for: .touchUpInside)
    }
    //MARK: - ACTIONS AND METHODS
    
    //MARK: - tapButtonReservation
    @objc func tapButtonReservation() {
        flagReservation = 1
        let vc = MyBookingView()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    //MARK: - createLabel
    func createLabel(placeHolderValue text: String) -> UILabel {
        let createLabel = UILabel()
        createLabel.font = UIFont(name: "Ubuntu-Regular", size: CGFloat(12).generateSizeForScreen)
        createLabel.text = text
        createLabel.backgroundColor = UIColor(named: ColorsBravve.backgroundBravve.rawValue)
        createLabel.textColor = .white
        return createLabel
    }
    
    //MARK: - Constraints
    
    //MARK: - iconsConstraints
    private func iconsConstraints() {
        
        logoIcon.constraintInsideTo(.top, view, CGFloat(56).generateSizeForScreen)
        logoIcon.constraintInsideTo(.leading, view, CGFloat(26).generateSizeForScreen)
        logoIcon.heightAnchorInSuperview(CGFloat(50).generateSizeForScreen)
        logoIcon.widthAnchorInSuperview(CGFloat(198.05).generateSizeForScreen)
        
        waveIcon.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        waveIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(130).generateSizeForScreen).isActive = true
        waveIcon.heightAnchor.constraint(equalToConstant: CGFloat(165.93).generateSizeForScreen).isActive = true
        waveIcon.widthAnchor.constraint(equalToConstant: CGFloat(250.37).generateSizeForScreen).isActive = true
        
    }
    
    //MARK: - viewsConstraints
    private func viewsConstraints() {
        
        scrollView.constraintOutsideTo(.top, waveIcon)
        scrollView.constraintInsideTo(.leading, view)
        scrollView.constraintInsideTo(.trailing, view)
        scrollView.constraintOutsideTo(.bottom, buttonReservation, CGFloat(2).generateSizeForScreen)
        
        viewToScroll.constraintInsideTo(.top, scrollView.contentLayoutGuide)
        viewToScroll.constraintInsideTo(.leading, scrollView.contentLayoutGuide)
        viewToScroll.constraintInsideTo(.trailing, scrollView.contentLayoutGuide)
        viewToScroll.constraintInsideTo(.bottom, scrollView.contentLayoutGuide)
        viewToScroll.constraintInsideTo(.width, scrollView.frameLayoutGuide)
        
        locationLabel.topAnchor.constraint(equalTo: locationIcon.topAnchor).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: locationIcon.leadingAnchor, constant: 17).isActive = true
        locationLabel.trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor).isActive = true
        
        schedulingLabel.topAnchor.constraint(equalTo: schedulingIcon.topAnchor).isActive = true
        schedulingLabel.leadingAnchor.constraint(equalTo: schedulingIcon.leadingAnchor, constant: 20).isActive = true
        schedulingLabel.trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor).isActive = true
        
        placeDetailLabel.topAnchor.constraint(equalTo: schedulingLabel.bottomAnchor, constant: 20).isActive = true
        placeDetailLabel.leadingAnchor.constraint(equalTo: locationDetailLabel.leadingAnchor).isActive = true
        placeDetailLabel.trailingAnchor.constraint(equalTo: locationDetailLabel.trailingAnchor).isActive = true
        
//        placeInfo1Label.topAnchor.constraint(equalTo: placeDetailLabel.bottomAnchor, constant: 20).isActive = true
//        placeInfo1Label.leadingAnchor.constraint(equalTo: locationDetailLabel.leadingAnchor).isActive = true
//        placeInfo1Label.trailingAnchor.constraint(equalTo: locationDetailLabel.trailingAnchor).isActive = true
//        
//        line2View.topAnchor.constraint(equalTo: placeInfo1Label.bottomAnchor, constant: 8).isActive = true
//        line2View.leadingAnchor.constraint(equalTo: line1View.leadingAnchor).isActive = true
//        line2View.trailingAnchor.constraint(equalTo: line1View.trailingAnchor).isActive = true
//        line2View.heightAnchorInSuperview(1)
//        
//        placeInfo2Label.topAnchor.constraint(equalTo: placeInfo1Label.bottomAnchor, constant: 16).isActive = true
//        placeInfo2Label.leadingAnchor.constraint(equalTo: locationDetailLabel.leadingAnchor).isActive = true
//        placeInfo2Label.trailingAnchor.constraint(equalTo: locationDetailLabel.trailingAnchor).isActive = true
//        
//        line3View.topAnchor.constraint(equalTo: placeInfo2Label.bottomAnchor, constant: 8).isActive = true
//        line3View.leadingAnchor.constraint(equalTo: line1View.leadingAnchor).isActive = true
//        line3View.trailingAnchor.constraint(equalTo: line1View.trailingAnchor).isActive = true
//        line3View.heightAnchorInSuperview(1)
//        
//        placeInfo3Label.topAnchor.constraint(equalTo: placeInfo2Label.bottomAnchor, constant: 16).isActive = true
//        placeInfo3Label.leadingAnchor.constraint(equalTo: locationDetailLabel.leadingAnchor).isActive = true
//        placeInfo3Label.trailingAnchor.constraint(equalTo: locationDetailLabel.trailingAnchor).isActive = true
//        
//        line4View.topAnchor.constraint(equalTo: placeInfo3Label.bottomAnchor, constant: 8).isActive = true
//        line4View.leadingAnchor.constraint(equalTo: line1View.leadingAnchor).isActive = true
//        line4View.trailingAnchor.constraint(equalTo: line1View.trailingAnchor).isActive = true
//        line4View.heightAnchorInSuperview(1)
//        
//        placeInfo4Label.topAnchor.constraint(equalTo: placeInfo3Label.bottomAnchor, constant: 16).isActive = true
//        placeInfo4Label.leadingAnchor.constraint(equalTo: locationDetailLabel.leadingAnchor).isActive = true
//        placeInfo4Label.trailingAnchor.constraint(equalTo: locationDetailLabel.trailingAnchor).isActive = true
//        
//        line5View.topAnchor.constraint(equalTo: placeInfo4Label.bottomAnchor, constant: 8).isActive = true
//        line5View.leadingAnchor.constraint(equalTo: line1View.leadingAnchor).isActive = true
//        line5View.trailingAnchor.constraint(equalTo: line1View.trailingAnchor).isActive = true
//        line5View.heightAnchorInSuperview(1)
//        
//        placeInfo5Label.topAnchor.constraint(equalTo: placeInfo4Label.bottomAnchor, constant: 16).isActive = true
//        placeInfo5Label.leadingAnchor.constraint(equalTo: locationDetailLabel.leadingAnchor).isActive = true
//        placeInfo5Label.trailingAnchor.constraint(equalTo: locationDetailLabel.trailingAnchor).isActive = true
//        
//        line6View.topAnchor.constraint(equalTo: placeInfo5Label.bottomAnchor, constant: 8).isActive = true
//        line6View.leadingAnchor.constraint(equalTo: line1View.leadingAnchor).isActive = true
//        line6View.trailingAnchor.constraint(equalTo: line1View.trailingAnchor).isActive = true
//        line6View.heightAnchorInSuperview(1)
//     
//        placeInfo6Label.topAnchor.constraint(equalTo: placeInfo5Label.bottomAnchor, constant: 16).isActive = true
//        placeInfo6Label.leadingAnchor.constraint(equalTo: locationDetailLabel.leadingAnchor).isActive = true
//        placeInfo6Label.trailingAnchor.constraint(equalTo: locationDetailLabel.trailingAnchor).isActive = true
//        
//        line7View.topAnchor.constraint(equalTo: placeInfo6Label.bottomAnchor, constant: 8).isActive = true
//        line7View.leadingAnchor.constraint(equalTo: line1View.leadingAnchor).isActive = true
//        line7View.trailingAnchor.constraint(equalTo: line1View.trailingAnchor).isActive = true
//        line7View.heightAnchorInSuperview(1)
//        
//        placeInfo7Label.topAnchor.constraint(equalTo: placeInfo6Label.bottomAnchor, constant: 16).isActive = true
//        placeInfo7Label.leadingAnchor.constraint(equalTo: locationDetailLabel.leadingAnchor).isActive = true
//        placeInfo7Label.trailingAnchor.constraint(equalTo: locationDetailLabel.trailingAnchor).isActive = true
//        placeInfo7Label.bottomAnchor.constraint(equalTo: viewToScroll.bottomAnchor, constant: -50).isActive = true
        
    }
    //MARK: - viewElementsConstraints
    private func viewElementsConstraints() {
        
        titleLabel.topAnchor.constraint(equalTo: viewToScroll.topAnchor, constant: 0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: viewToScroll.leadingAnchor, constant: CGFloat(26).generateSizeForScreen).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: viewToScroll.trailingAnchor, constant: CGFloat(-26).generateSizeForScreen).isActive = true
        
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: CGFloat(10).generateSizeForScreen).isActive = true
        subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        
        info1Label.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: CGFloat(20).generateSizeForScreen).isActive = true
        info1Label.leadingAnchor.constraint(equalTo: subtitleLabel.leadingAnchor).isActive = true
        info1Label.trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor).isActive = true
        
        lineView.topAnchor.constraint(equalTo: info1Label.bottomAnchor, constant: CGFloat(24).generateSizeForScreen).isActive = true
        lineView.leadingAnchor.constraint(equalTo: subtitleLabel.leadingAnchor).isActive = true
        lineView.trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor, constant: CGFloat(-5).generateSizeForScreen).isActive = true
        lineView.heightAnchorInSuperview(CGFloat(1).generateSizeForScreen)
        
        locationDetailLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: CGFloat(20).generateSizeForScreen).isActive = true
        locationDetailLabel.leadingAnchor.constraint(equalTo: subtitleLabel.leadingAnchor).isActive = true
        locationDetailLabel.trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor).isActive = true
        
        locationIcon.topAnchor.constraint(equalTo: locationDetailLabel.bottomAnchor, constant: CGFloat(20).generateSizeForScreen).isActive = true
        locationIcon.leadingAnchor.constraint(equalTo: locationDetailLabel.leadingAnchor).isActive = true
        locationIcon.heightAnchor.constraint(equalToConstant: CGFloat(14).generateSizeForScreen).isActive = true
        locationIcon.widthAnchor.constraint(equalToConstant: CGFloat(10.49).generateSizeForScreen).isActive = true
        
        schedulingIcon.topAnchor.constraint(equalTo: locationIcon.bottomAnchor, constant: CGFloat(34).generateSizeForScreen).isActive = true
        schedulingIcon.leadingAnchor.constraint(equalTo: locationIcon.leadingAnchor).isActive = true
        schedulingIcon.heightAnchor.constraint(equalToConstant: CGFloat(14).generateSizeForScreen).isActive = true
        schedulingIcon.widthAnchor.constraint(equalToConstant: CGFloat(14).generateSizeForScreen).isActive = true
        
        locationLabel.topAnchor.constraint(equalTo: locationIcon.topAnchor).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: locationIcon.leadingAnchor, constant: CGFloat(17).generateSizeForScreen).isActive = true
        locationLabel.trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor).isActive = true
        
        schedulingLabel.topAnchor.constraint(equalTo: schedulingIcon.topAnchor).isActive = true
        schedulingLabel.leadingAnchor.constraint(equalTo: schedulingIcon.leadingAnchor, constant: CGFloat(20).generateSizeForScreen).isActive = true
        schedulingLabel.trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor).isActive = true
        
        placeDetailLabel.topAnchor.constraint(equalTo: schedulingLabel.bottomAnchor, constant: CGFloat(20).generateSizeForScreen).isActive = true
        placeDetailLabel.leadingAnchor.constraint(equalTo: locationDetailLabel.leadingAnchor).isActive = true
        placeDetailLabel.trailingAnchor.constraint(equalTo: locationDetailLabel.trailingAnchor).isActive = true
        
        labelsStack.constraintOutsideTo(.top, placeDetailLabel, CGFloat(13).generateSizeForScreen)
        labelsStack.constraintInsideTo(.leading, placeDetailLabel)
        labelsStack.constraintInsideTo(.trailing, placeDetailLabel)
        labelsStack.bottomAnchor.constraint(equalTo: viewToScroll.bottomAnchor, constant: CGFloat(-20).generateSizeForScreen).isActive = true
    }
    
}