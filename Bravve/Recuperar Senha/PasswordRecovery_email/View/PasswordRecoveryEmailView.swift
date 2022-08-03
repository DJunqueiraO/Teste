//
//  Recuperar1View.swift
//  Bravve
//
//  Created by user218260 on 7/15/22.
//

import Foundation
import UIKit

class PasswordRecoveryEmailView: UIViewController {
    
    let backgroundImage = UIImageView()
    
    let buttonBack = UIButton()
    
    let imageLogo = UIImageView()
    
    private lazy var progressBarStackView: (stack: UIStackView,
                                            buttons: [UIButton]) = {
        
        let buttons = createProgressBarButtons([
                                                "emailBlue",
                                                "padlockGray"
                                                ])
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.spacing = 7
        
        return (stack: stackView,
                buttons: buttons)
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Informe seu e-mail para enviarmos um código de confirmação!"
        label.textAlignment = .center
        label.font = UIFont(name: "Ubuntu-Light", size: 16)
        label.textColor = UIColor(named: "label")
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textFieldEmail: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "Ubuntu-Medium", size: 16)
        textField.textColor = UIColor(named: "label")
        textField.backgroundColor = .white
        textField.isHidden = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let labelEmail_: UILabel = {
        let label = UILabel()
        label.text = "E-mail"
        label.font = UIFont(name: "Ubuntu-Regular", size: 15)
        label.textColor = UIColor(named: "labelTextField")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackMargins: CGFloat = 12
        
    lazy var stackViewEmail: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [labelEmail_, textFieldEmail])
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.backgroundColor = .white
        stackView.layer.borderColor = UIColor(named: "textFieldBorder")?.cgColor
        stackView.layer.borderWidth = 1
        stackView.layer.cornerRadius = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: stackMargins,
                                                               left: stackMargins,
                                                               bottom: stackMargins,
                                                               right: stackMargins)
        return stackView
        
    }()
    
    let customShaddow: UIView = {
             
             let customShaddow = UIView()
             customShaddow.backgroundColor = UIColor(named: "blueNav")
             customShaddow.layer.cornerRadius = 8
             customShaddow.isHidden = true
             
             return customShaddow
         }()

    
    let buttonContinue = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "background")

        view.addSubviews([backgroundImage, buttonBack, imageLogo, progressBarStackView.stack, label, customShaddow, stackViewEmail, buttonContinue])
        addConstraints()
        addTargets()

    }
    
    func addConstraints() {
        
        buttonBack.setToBackButtonDefault(.backPink)
        imageLogo.setLogoToDefault()
        buttonContinue.setToBottomButtonKeyboardDefault()
        backgroundImage.setWayToDefault(.wayCell)
        
        NSLayoutConstraint.activate([
            
          
            
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            label.topAnchor.constraint(equalTo: progressBarStackView.stack.bottomAnchor, constant: 50),
                        
            stackViewEmail.heightAnchor.constraint(equalToConstant: 65),
            
        ])
        
        progressBarStackView.stack.constraintOutsideTo(.top, imageLogo, 50)
        progressBarStackView.stack.constraintInsideTo(.centerX, view.safeAreaLayoutGuide)
        progressBarStackView.stack.heightAnchorInSuperview()
        
        stackViewEmail.constraintOutsideTo(.top, label, 70)
        stackViewEmail.constraintInsideTo(.leading, label)
        stackViewEmail.constraintInsideTo(.trailing, label)
        
        customShaddow.constraintInsideTo(.top, stackViewEmail)
        customShaddow.constraintInsideTo(.leading, stackViewEmail)
        customShaddow.constraintInsideTo(.trailing, stackViewEmail)
        
        view.addConstraint(NSLayoutConstraint(item: customShaddow,
                                              attribute: .bottom,
                                              relatedBy: .equal,
                                              toItem: stackViewEmail,
                                              attribute: .bottom,
                                              multiplier: 1,
                                              constant: 1))
        
    }
    
    func addTargets() {
        
        buttonBack.addTarget(self, action: #selector(actionButtonBack), for: .touchUpInside)
        
        let stackViewTap = UITapGestureRecognizer(target: self, action: #selector(stackViewTapped))
        stackViewEmail.addGestureRecognizer(stackViewTap)
    }
    
    @objc func stackViewTapped() {
          
        labelEmail_.font = UIFont(name: "Ubuntu-Regular", size: 11)
                
        customShaddow.isHidden = false
        
        textFieldEmail.isHidden = false
        
        textFieldEmail.addTarget(self, action: #selector(changeText), for: .editingChanged)
    }

    
    @objc func actionButtonBack(sender: UIButton){
        print("voltar")
    }
  
    
    @objc func actionButtonContinue() {

        print("ok")
    }
    
    func freezeButton_() {
        
        buttonContinue.removeTarget(nil, action: #selector(actionButtonContinue), for: .touchUpInside)
        
        buttonContinue.backgroundColor = UIColor(named: "buttonGray")
    }


    @objc func changeText(_ sender: UITextField) {
           
           if sender.text != "" {

               buttonContinue.addTarget(nil, action: #selector(actionButtonContinue), for: .touchUpInside)
               buttonContinue.backgroundColor = UIColor(named: "buttonPink")
           }
           else {
               
               buttonContinue.removeTarget(nil, action: #selector(actionButtonContinue), for: .touchUpInside)
               buttonContinue.backgroundColor = UIColor(named: "buttonGray")
           }
       }

    
    
}