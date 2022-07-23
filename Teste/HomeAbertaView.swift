//
//  HomeView.swift
//  Teste
//
//  Created by Josicleison on 22/07/22.
//

import UIKit

class HomeAbertaView: UIViewController {
    
    let titleLabel = UILabel()
    
    lazy var navigationBar: UINavigationBar = {
        
        guard let navigationBar = navigationController?.navigationBar else {return UINavigationBar()}
        
        let firstFrame = CGRect(x: 25,
                                y: navigationBar.frame.size.height/4,
                                width: navigationBar.frame.size.width*0.8,
                                height: navigationBar.frame.size.height/2)
        
        let stackView = UIStackView(frame: firstFrame)
        
        stackView.addArrangedSubview(viewElements.leftStackView)
        stackView.addArrangedSubview(viewElements.leftButton)
        stackView.addArrangedSubview(viewElements.rightStackView)
        stackView.addArrangedSubview(viewElements.rightButton)
        
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 8
        stackView.setToDefaultBackgroundColor()
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10,
                                               left: 10,
                                               bottom: 10,
                                               right: 10)
        navigationBar.addSubview(stackView)
        
        return navigationBar
    }()
    
    let viewElements: (leftStackView: UIStackView,
                       leftButton: UIButton,
                       rightStackView: UIStackView,
                       rightButton: UIButton) = {
        
        let leftButton = UIButton(),
            stateLabel = UILabel(),
            stateChosedLabel = UILabel(),
            leftStackView = UIStackView(arrangedSubviews: [stateLabel,
                                                           stateChosedLabel]),
            rightButton = UIButton(),
            cityLabel = UILabel(),
            cityChosedLabel = UILabel(),
            rightStackView = UIStackView(arrangedSubviews: [cityLabel,
                                                            cityChosedLabel])
        
        let handler = {(action: UIAction) in
            
            print(action.title)
        }
        
        stateLabel.text = "UF"
        leftButton.setMenuForButton([
            
            UIAction(title: "action1",handler: handler),
            UIAction(title: "action2",handler: handler)
        
        ])
        leftButton.setTitle("", for: .normal)
        
        cityLabel.text = "Cidade"
        rightButton.setMenuForButton([
            
            UIAction(title: "action1",handler: handler),
            UIAction(title: "action2",handler: handler)
        
        ])
        rightButton.setTitle("", for: .normal)
        
        return (leftStackView: leftStackView,
                leftButton: leftButton,
                rightStackView: rightStackView,
                rightButton: rightButton)
    }()
    
//    let tabBar: UITabBar = {
//
//        let tabBar = UITabBar()
//        tabBar.backgroundColor = .red
//
//        return tabBar
//    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupView()
        setupDefaults()
        setupConstraints()
    }
    
    func setupView() {
        
        view.addSubviews([titleLabel])
        view.setToDefaultBackgroundColor()
    }
    
    func setupDefaults() {
        
        titleLabel.setToDefault(text: "Espaços")
    }
    
    func setupConstraints() {
        
        viewElements.leftStackView.widthAnchorInSuperview(navigationBar.frame.size.width*0.1)
        viewElements.leftButton.widthAnchorInSuperview(navigationBar.frame.size.width*0.1)
        viewElements.rightStackView.addLeadingLineWithColor(color: .red)
        viewElements.rightButton.widthAnchorInSuperview(navigationBar.frame.size.width*0.1)
        
        titleLabel.constraintInsideTo(.top, view.safeAreaLayoutGuide, 15)
        titleLabel.constraintInsideTo(.leading, view.safeAreaLayoutGuide, 20)
        
//        tabBar.constraintInsideTo(.leading, view.safeAreaLayoutGuide)
//        tabBar.constraintInsideTo(.trailing, view.safeAreaLayoutGuide)
//        tabBar.constraintInsideTo(.bottom, view.safeAreaLayoutGuide)
    }
}

