//
//  NomeView.swift
//  Bravve
//
//  Created by user218260 on 7/15/22.
//

import UIKit

class NomeViewModel {
    
    private var stage: Stage
    var delegate: NomeViewModelProtocol?
    
    init(_ stage: Stage) {
        
        self.stage = stage
    }
    
    func createDDIs(_ handler: @escaping UIActionHandler) -> [UIAction] {
        
        var ddis: [UIAction] = []
        
        for i in 1...235 {
            
            ddis.append(UIAction(title: "+\(i)" , handler: handler))
        }
        
        return ddis
    }
    
    func changeScreenWithProgressBar(_ sender: UIButton) {
        
        switch sender.currentImage {
            
            case UIImage(named: IconsBravve.userBlue.rawValue):
            
                makeNameScreen()
                stage = .first
            
            case UIImage(named: IconsBravve.userGray.rawValue):
            
                makeNameScreen()
                stage = .first
            
            case UIImage(named: IconsBravve.cellBlue.rawValue):
            
                makePhoneScreen()
                stage = .second
            
            case UIImage(named: IconsBravve.cellGray.rawValue):
            
                makePhoneScreen()
                stage = .second
            
            default:
                
                makeEmailScreen()
                stage = .thirdy
        }
    }
    
    func makeScreen() {
        
        switch stage {
            
            case .first:
            
                makeNameScreen()
            
            case .second:
            
                makePhoneScreen()
            
            default:
            
                makeEmailScreen()
        }
    }
    
    func advanceScreen() {
        
        switch stage {
            
            case .first:
            
                makePhoneScreen()
                stage = .second
            
            case .second:
            
                makeEmailScreen()
                stage = .thirdy
            
            default: break
        }
    }
    
    func turnBackScreen() {
        
        switch stage {

            case .thirdy:

                makePhoneScreen()
                stage = .second

            case .second:

                makeNameScreen()
                stage = .first

            default: break
        }
    }
    
    private func makeNameScreen() {
        
        delegate?.setIshidden(leftStackView: true,
                              ddiChoseLabel: false,
                              ways: [true, true, false])
        
        delegate?.setFont(font: UIFont(name: FontsBravve.light.rawValue,
                                       size: CGFloat(15).generateSizeForScreen) ?? UIFont())
        
        delegate?.setText(rightLabel: "Nome Completo",
                          rightTextField: "",
                          infoLabel: "Para começarmos a conversar, pode nos contar seu nome e sobrenome!")
        
        delegate?.setProgressBar(buttons: [false, true, true, false, true, false])
        
        delegate?.freezeButton()
        
        delegate?.setKeyboardType(keyboardType: .namePhonePad)
    }
    
    private func makePhoneScreen() {
        
        delegate?.setIshidden(leftStackView: false,
                              ddiChoseLabel: true,
                              ways: [true, false, true])
        
        delegate?.setFont(font: UIFont(name: FontsBravve.light.rawValue,
                                       size: CGFloat(15).generateSizeForScreen) ?? UIFont())
        
        delegate?.setText(rightLabel: "Telefone",
                          rightTextField: "",
                          infoLabel: "Precisamos do seu telefone com DDD!\n Por favor, informe o seu país também.")
        
        delegate?.setProgressBar(buttons: [true, false, false, true, true, false])
        
        delegate?.freezeButton()
        
        delegate?.setKeyboardType(keyboardType: .numberPad)
    }
    
    private func makeEmailScreen() {
        
        delegate?.setIshidden(leftStackView: true,
                              ddiChoseLabel: false,
                              ways: [false, true, true])
        
        delegate?.setFont(font: UIFont(name: FontsBravve.light.rawValue,
                                       size: CGFloat(15).generateSizeForScreen) ?? UIFont())
        
        delegate?.setText(rightLabel: "E-mail",
                          rightTextField: "",
                          infoLabel: "Qual seu email? Não se preocupe, não vamos encher sua caixa de entrada.")
        
        delegate?.setProgressBar(buttons: [true, false, true, false, false, true])
        
        delegate?.freezeButton()
        
        delegate?.setKeyboardType(keyboardType: .emailAddress)
    }
}

protocol NomeViewModelProtocol {
    
    func setIshidden(leftStackView: Bool,
                     ddiChoseLabel: Bool,
                     ways: [Bool])
    
    func setFont(font: UIFont)
    
    func setText(rightLabel: String,
                 rightTextField: String,
                 infoLabel: String)
    
    func setProgressBar(buttons: [Bool])
    
    func freezeButton()
    
    func setKeyboardType(keyboardType: UIKeyboardType)
}