//
//  ConfirmarDadosView.swift
//  Bravve
//
//  Created by user218260 on 7/15/22.
//

import Foundation
import UIKit

class ConfirmDataView: UIViewController {
    
    let backgroundImage1: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "wayCell")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let backgroundImage2: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "wayConfirm")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    let buttonBack = UIButton()
    
    let imageLogo = UIImageView()
    
    private lazy var progressBarStackView: (stack: UIStackView,
                                            buttons: [UIButton]) = {
        
        let buttons = createProgressBarButtons(["userGray",
                                                "cellGray",
                                                "emailGray",
                                                "padlockGray",
                                                "pencilBlue"])
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.spacing = 7
        
        return (stack: stackView,
                buttons: buttons)
    }()
    
    
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Bravo! Que tal revisar suas informações, aqui você pode alterá-las!"
        label.textAlignment = .center
        label.font = UIFont(name: "Ubuntu-Light", size: 16)
        label.textColor = UIColor(named: "label")
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let contentView: UIView = {
      let view = UIView()
      view.backgroundColor = UIColor(named: "background")
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    
    let labelName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Ubuntu-Medium", size: 15)
        label.textColor = UIColor(named: "label")
        //label.text = "Ana Maria Silva"
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelCell: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Ubuntu-Medium", size: 15)
        label.textColor = UIColor(named: "label")
       // label.text = "11 99686 2647"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelEmail: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Ubuntu-Medium", size: 15)
        label.textColor = UIColor(named: "label")
       // label.text = "teste@bravve.com.br"
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var editButton1: UIButton = {
        let button = myButton()
        return button
    }()
    lazy var editButton2: UIButton = {
        let button = myButton()
        return button
    }()
    lazy var editButton3: UIButton = {
        let button = myButton()
        return button
    }()
    
    lazy var stackViewName: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelName, editButton1])
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.backgroundColor = .white
        stackView.layer.borderWidth = 1
        stackView.layer.cornerRadius = 8
        stackView.layer.borderColor = UIColor(named: "textFieldBorder")?.cgColor
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 20)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
        }()
    
    lazy var stackViewCell: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelCell, editButton2])
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.backgroundColor = .white
        stackView.layer.borderWidth = 1
        stackView.layer.cornerRadius = 8
        stackView.layer.borderColor = UIColor(named: "textFieldBorder")?.cgColor
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 20)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
        }()
    
    lazy var stackViewEmail: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelEmail, editButton3])
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.backgroundColor = .white
        stackView.layer.borderWidth = 1
        stackView.layer.cornerRadius = 8
        stackView.layer.borderColor = UIColor(named: "textFieldBorder")?.cgColor
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 20)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
        }()
    
    lazy var stackViewLabels: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackViewName, stackViewCell, stackViewEmail])
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
        }()
    
    let buttonContinue: UIButton = {
        let button = UIButton()
        button.setTitle("Continuar", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont(name: "Ubuntu-Bold", size: 16)
        button.backgroundColor = UIColor(named: "buttonPink")
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "background")
        
        view.addSubviews([backgroundImage2, buttonBack, imageLogo, progressBarStackView.stack, label, contentView])
        contentView.addSubviews([backgroundImage1, stackViewLabels, buttonContinue])
        
        addConstraints()
        addTargets()
      
        
    }
    
    func myButton() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: "edit-blue"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func addConstraints() {
        
        buttonBack.setToBackButtonDefault(.backPink)
        imageLogo.setLogoToDefault()
        
        NSLayoutConstraint.activate([
        
            
            
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            label.topAnchor.constraint(equalTo: progressBarStackView.stack.bottomAnchor, constant: 50),
            
            stackViewName.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07),
            editButton1.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.095),
            
            stackViewCell.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07),
            editButton2.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.095),
            
            stackViewEmail.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07),
            editButton3.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.095),
            
            stackViewLabels.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackViewLabels.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
            stackViewLabels.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 50),
            contentView.heightAnchor.constraint(equalToConstant: view.frame.height/2.7),
            buttonContinue.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.068),
            buttonContinue.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22),
            buttonContinue.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
            buttonContinue.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
          
            
            ])
        
        progressBarStackView.stack.constraintOutsideTo(.top, imageLogo, 50)
        progressBarStackView.stack.constraintInsideTo(.centerX, view.safeAreaLayoutGuide)
        progressBarStackView.stack.heightAnchorInSuperview()
        
        backgroundImage1.constraintInsideTo(.leading, contentView.safeAreaLayoutGuide)
        backgroundImage1.constraintInsideTo(.top, contentView.safeAreaLayoutGuide, -60)
        
        backgroundImage2.constraintInsideTo(.trailing, view.safeAreaLayoutGuide)
        backgroundImage2.constraintInsideTo(.top, view.safeAreaLayoutGuide)
        backgroundImage2.heightAnchorInSuperview(130)
        backgroundImage2.widthAnchorInSuperview(280)
    }
    
    func addTargets() {
        
        buttonBack.addTarget(self, action: #selector(actionButtonBack), for: .touchUpInside)
        
        progressBarStackView.buttons[0].addTarget(self, action: #selector(actionButtonPersonalData), for: .touchUpInside)
        
        progressBarStackView.buttons[1].addTarget(self, action: #selector(actionButtonCell), for: .touchUpInside)
        
        progressBarStackView.buttons[2].addTarget(self, action: #selector(actionButtonEmail), for: .touchUpInside)
        
        progressBarStackView.buttons[3].addTarget(self, action: #selector(actionButtonPassword), for: .touchUpInside)
        
        buttonContinue.addTarget(self, action: #selector(actionButtonContinue), for: .touchUpInside)
        
        editButton1.addTarget(self, action: #selector(actionEditButton1), for: .touchUpInside)
        editButton2.addTarget(self, action: #selector(actionEditButton2), for: .touchUpInside)
        editButton3.addTarget(self, action: #selector(actionEditButton3), for: .touchUpInside)
        
    }
    
    
    @objc func actionButtonBack() {
        print("voltar")
    }
    
    @objc func actionButtonPersonalData() {
        print("dados pessoais")
    }
   
    @objc func actionButtonCell() {
        print("celular")
    }
    
    @objc func actionButtonEmail() {
        print("email")
    }
    
    @objc func actionButtonPassword() {
        print("senha")
    }
    
    @objc func actionButtonContinue() {
        print("continuar")
    }
    
    @objc func actionEditButton1() {
        print("tela dados pessoais")
    }
    
    @objc func actionEditButton2() {
        print("tela celular")
    }
    
    @objc func actionEditButton3() {
        print("tela email")
    }
}