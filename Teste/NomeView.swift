//
//  NomeView.swift
//  Bravve
//
//  Created by user218260 on 7/15/22.
//

import UIKit

class NomeView: UIViewController {
    
    let backButton = UIButton()
    
    let bravveIcon = UIImageView()
    
    let registerButton = UIButton()
    
    let progressBarStackView: (stack: UIStackView,
                               personalData: UIButton,
                               phone: UIButton,
                               email: UIButton) = {
        
        let stackView = UIStackView()
        let buttons = stackView.createProgressBarButtons(["person.circle.fill",
                                                          "iphone.circle.fill",
                                                          "mail.stack.fill",
                                                          "lock.circle.fill",
                                                          "pencil.circle.fill"])
        buttons[0].setTitle(" Dados pessoais", for: .normal)
        buttons[0].tintColor = .systemBlue
        
        stackView.backgroundColor = .white
        stackView.spacing = 7
        
        return (stack: stackView,
                personalData: buttons[0],
                phone: buttons[1],
                email: buttons[2])
    }()
    
    let infoLabel: UILabel = {
        
        let infoLabel = UILabel()
        infoLabel.setToDefault(text: "Para começarmos a conversar, pode nos contar seu nome e sobrenome!")
        
        return infoLabel
    }()
    
    let customShaddow: UIView = {
        
        let customShaddow = UIView()
        customShaddow.backgroundColor = .blue
        customShaddow.layer.cornerRadius = 8
        customShaddow.isHidden = true
        
        return customShaddow
    }()
    
    let viewElements: (registerStackView: UIStackView,
                       leftStackView: UIStackView,
                       rightTextField: UITextField,
                       rightLabel: UILabel,
                       ddiChoseLabel: UILabel,
                       ddisLabel: UILabel,
                       ddisButton: UIButton) = {
        
        let stackMargins: CGFloat = 10
        
        let ddisLabel = UILabel()
        ddisLabel.text = "+55"
        ddisLabel.font = UIFont(name: "Ubuntu-Light", size: 15)
        
        let ddiChoseLabel = UILabel()
        ddiChoseLabel.text = "+55"
        ddiChoseLabel.isHidden = true
        ddiChoseLabel.font = UIFont(name: "Ubuntu-Medium", size: 16)
        
        let stackView = UIStackView(arrangedSubviews: [ddisLabel, ddiChoseLabel])
        stackView.spacing = 10
        stackView.axis = .vertical
        
        let ddisButton = UIButton()
        
        let leftStackView = UIStackView(arrangedSubviews: [stackView, ddisButton])
        leftStackView.isHidden = true
        leftStackView.backgroundColor = .white
        leftStackView.layer.cornerRadius = 10
        leftStackView.isLayoutMarginsRelativeArrangement = true
        leftStackView.layoutMargins = UIEdgeInsets(top: stackMargins,
                                                   left: stackMargins,
                                                   bottom: stackMargins,
                                                   right: 0)
        
        let rightLabel = UILabel()
        rightLabel.text = "Nome Completo"
        rightLabel.font = UIFont(name: "Ubuntu-Light", size: 15)
        
        let rightTextField = UITextField()
        rightTextField.font = UIFont(name: "Ubuntu-Medium", size: 16)
        rightTextField.isHidden = true
        rightTextField.keyboardType = .namePhonePad
        
        let rightStackView = UIStackView(arrangedSubviews: [rightLabel,
                                                            rightTextField])
        rightStackView.spacing = 10
        rightStackView.axis = .vertical
        rightStackView.backgroundColor = .white
        rightStackView.layer.cornerRadius = 8
        rightStackView.isLayoutMarginsRelativeArrangement = true
        rightStackView.layoutMargins = UIEdgeInsets(top: stackMargins,
                                                       left: stackMargins,
                                                       bottom: stackMargins,
                                                       right: stackMargins)
        
        let registerStackView = UIStackView(arrangedSubviews: [leftStackView,
                                                               rightStackView])
        registerStackView.backgroundColor = .white
        registerStackView.layer.borderWidth = 1
        registerStackView.spacing = 15
        registerStackView.layer.cornerRadius = 8
        
        return (registerStackView: registerStackView,
                leftStackView: leftStackView,
                rightTextField: rightTextField,
                rightLabel: rightLabel,
                ddiChoseLabel: ddiChoseLabel,
                ddisLabel: ddisLabel,
                ddisButton: ddisButton)
    }()
    
    let nomeViewModel = NomeViewModel()
    
    override func viewDidLoad() {
        
        view.addSubviews([bravveIcon, backButton, progressBarStackView.stack, infoLabel, customShaddow, viewElements.registerStackView, registerButton])
        
        setupDefault()
        
        viewElements.ddisButton.setMenuForButton(nomeViewModel.createDDIs({(action: UIAction) in

            self.viewElements.ddiChoseLabel.text = action.title
        }))
        
        setupConstraints()
        
        view.backgroundColor = .white
        
        backButton.addTarget(self,
                             action: #selector(back),
                             for: .touchUpInside)
        progressBarStackView.personalData.addTarget(self,
                                                    action: #selector(progressBarAction),
                                                    for: .touchUpInside)
        progressBarStackView.phone.addTarget(self,
                                             action: #selector(progressBarAction),
                                             for: .touchUpInside)
        progressBarStackView.email.addTarget(self,
                                             action: #selector(progressBarAction),
                                             for: .touchUpInside)
        
        let stackViewTap = UITapGestureRecognizer(target: self, action: #selector(stackViewTapped))
        viewElements.registerStackView.addGestureRecognizer(stackViewTap)
        
        super.viewDidLoad()
    }
    
    func setupDefault() {
        
        registerButton.setToBottomButtonDefault()
        bravveIcon.setLogoToDefault()
        backButton.setToBackButtonDefault()
    }
    
    @objc func stackViewTapped() {
        
        viewElements.rightLabel.font = UIFont.systemFont(ofSize: 11)
        viewElements.ddisLabel.font = UIFont.systemFont(ofSize: 11)
        
        customShaddow.isHidden = false
        
        viewElements.rightTextField.isHidden = false
        viewElements.ddiChoseLabel.isHidden = false
        viewElements.ddisButton.isEnabled = true
        
        viewElements.rightTextField.addTarget(self,
                                              action: #selector(changeText),
                                              for: .editingChanged)
    }
    
    func setupConstraints() {
        
        progressBarStackView.stack.constraintOutsideTo(.top, bravveIcon, 50)
        progressBarStackView.stack.constraintInsideTo(.centerX, view.safeAreaLayoutGuide)
        
        infoLabel.constraintOutsideTo(.top, progressBarStackView.stack, 50)
        infoLabel.constraintInsideTo(.leading, view.safeAreaLayoutGuide, 40)
        infoLabel.constraintInsideTo(.trailing, view.safeAreaLayoutGuide, 40)
        
        viewElements.registerStackView.constraintOutsideTo(.top, infoLabel, 50)
        viewElements.registerStackView.constraintInsideTo(.leading, infoLabel)
        viewElements.registerStackView.constraintInsideTo(.trailing, infoLabel)
        
        customShaddow.constraintInsideTo(.top, viewElements.registerStackView)
        customShaddow.constraintInsideTo(.leading, viewElements.registerStackView)
        customShaddow.constraintInsideTo(.trailing, viewElements.registerStackView)
        customShaddow.constraintTo(.bottom, viewElements.registerStackView, 1)
        
        viewElements.leftStackView.widthAnchorInSuperview(80)
        viewElements.ddisButton.widthAnchorInSuperview()
    }
        
    @objc func changeScreen() {
        
        nomeViewModel.delegate = self
        nomeViewModel.advanceScreen()
    }
    
    @objc func progressBarAction(_ sender: UIButton) {
        
        nomeViewModel.delegate = self
        nomeViewModel.changeScreenWithProgressBar(sender)
    }
    
    @objc func back() {
        
        nomeViewModel.turnBackScreen()
    }
    
    @objc func changeText(_ sender: UITextField) {
        
        if sender.text != "" {

            registerButton.addTarget(nil,
                                     action: #selector(changeScreen),
                                     for: .touchUpInside)
            registerButton.backgroundColor = .red
        }
        else {
            
            registerButton.removeTarget(nil,
                                        action: #selector(changeScreen),
                                        for: .touchUpInside)
            registerButton.backgroundColor = .gray
        }
    }
}

extension NomeView: NomeViewModelProtocol {
    
    func setIshidden(leftStackView: Bool,
                     ddiChoseLabel: Bool,
                     rightTextField: Bool) {
        
        viewElements.leftStackView.isHidden = leftStackView
        viewElements.ddiChoseLabel.isHidden = ddiChoseLabel
        viewElements.ddisButton.isEnabled = false
        viewElements.rightTextField.isHidden = rightTextField
    }
    
    func setFont(font: UIFont) {
        
        viewElements.ddisLabel.font = font
        viewElements.rightLabel.font = font
    }
    
    func setText(rightLabel: String,
                 rightTextField: String,
                 infoLabel: String) {
        
        viewElements.rightLabel.text = rightLabel
        viewElements.rightTextField.text = rightTextField

        self.infoLabel.text = infoLabel
    }
    
    func setProgressBar(personalDataTitle: String,
                        personalDataTint: UIColor,
                        phoneNumberTitle: String,
                        phoneNumberTint: UIColor,
                        emailTitle: String,
                        emailTint: UIColor) {
        
        progressBarStackView.personalData.setTitle(personalDataTitle, for: .normal)
        progressBarStackView.personalData.tintColor = personalDataTint
        progressBarStackView.phone.setTitle(phoneNumberTitle, for: .normal)
        progressBarStackView.phone.tintColor = phoneNumberTint
        progressBarStackView.email.setTitle(emailTitle, for: .normal)
        progressBarStackView.email.tintColor = emailTint
    }
    
    func freezeButton() {
        
        registerButton.removeTarget(nil,
                                    action: #selector(changeScreen),
                                    for: .touchUpInside)
        registerButton.backgroundColor = .gray
        
        viewElements.registerStackView.layer.shadowOpacity = 0
    }
    
    func setKeyboardType(keyboardType: UIKeyboardType) {
        
        viewElements.rightTextField.keyboardType = keyboardType
    }
}
