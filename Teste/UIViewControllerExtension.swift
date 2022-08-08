//
//  ExtensionUIView.swift
//  Bravve
//
//  Created by Evandro Rodrigo Minamoto on 28/07/22.
//

import UIKit
    
//Extensions related to creation of view elements on UIViewController
extension UIViewController {
    
/* This is a function created with the aim of generating buttons in the capsule configuration
*/
    
    open func createCapsuleButtons(_ buttonTitles: [String],
                                   _ backgroundColor: ColorsBravve = .capsuleButtonSelected,
                                   strokeColor: UIColor? = UIColor(named: ColorsBravve.textFieldBorder.rawValue)) -> [UIButton] {
        
        var buttons: [UIButton] = []
        
        for title in buttonTitles {
            
            let button = UIButton()
            button.setToDefaultCapsuleButton(title,
                                             backgroundColor,
                                             strokeColor: strokeColor)
            
            buttons.append(button)
        }
        
        return buttons
    }
    
/* This is a function created with the aim of creating a progress bar buttons, which is a custom bar in the app that has a series of navigable buttons, but without actions */
    
    open func createProgressBarButtonsWithoutActions(_ buttonImageNames: [String]) -> [UIButton] {
        
        var buttons: [UIButton] = []
        
        for name in buttonImageNames {
            
            let button = UIButton()
            button.setToProgressBarButtonDefault(name)
            
            buttons.append(button)
        }
        
        return buttons
    }
    
/* This is a function created with the aim of creating a progress bar buttons, which is a custom bar in the app that has a series of navigable buttons */
    
    open func createProgressBarButtons(_ buttonImageNames: [String]) -> [UIButton] {
        
        var buttons: [UIButton] = []
        
        for name in buttonImageNames {
            
            let button = UIButton()
            
            switch name{
                
                case IconsBravve.activitiesGray.rawValue: break
                
                case IconsBravve.calendarGray.rawValue: break
                
                case IconsBravve.cellGray.rawValue:
                    
                    let handler = {(action: UIAction) in
                        
                        let nomeView = NomeView(.second)
                        nomeView.modalPresentationStyle = .fullScreen
                        self.present(nomeView,
                                     animated: false)
                    }

                    button.addAction(UIAction(handler: handler), for: .touchUpInside)
                
                case IconsBravve.creditGray.rawValue: break
                
                case IconsBravve.emailGray.rawValue:
                    
                    let handler = {(action: UIAction) in
                        
                        let nomeView = NomeView(.thirdy)
                        nomeView.modalPresentationStyle = .fullScreen
                        self.present(nomeView,
                                     animated: false)
                    }

                    button.addAction(UIAction(handler: handler), for: .touchUpInside)
                
                case IconsBravve.hobbiesGray.rawValue: break
                
                case IconsBravve.noteGray.rawValue: break
                
                case IconsBravve.padlockGray.rawValue: break
                
                case IconsBravve.pencilGray.rawValue: break
                
                case IconsBravve.photoGray.rawValue:
            
                    let handler = {(action: UIAction) in
                        
                        let fotoView = FotoView()
                        fotoView.modalPresentationStyle = .fullScreen
                        self.present(fotoView,
                                     animated: false)
                    }

                    button.addAction(UIAction(handler: handler), for: .touchUpInside)
                    
                case IconsBravve.userGray.rawValue:
                    
                    let handler = {(action: UIAction) in
                        
                        let nomeView = NomeView(.first)
                        nomeView.modalPresentationStyle = .fullScreen
                        self.present(nomeView,
                                     animated: false)
                    }

                    button.addAction(UIAction(handler: handler), for: .touchUpInside)
                
                default: break
            }
            
            button.setToProgressBarButtonDefault(name)
            
            buttons.append(button)
        }
        
        return buttons
    }
}

//Extension related to regex
extension UIViewController {
    
/* This is a regex that checks if it's a valid phone */
    
    open func validateCellPhone(_ phone: String) -> Bool {
        
        let phoneRegEx = "\\([0-9]{4}+\\)[0-9]{5}+-[0-9]{4}||[0-9]{13}"

        let phonePred = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        
        if phonePred.evaluate(with: phone) {
            
            return true
        }
        return false
    }
}

extension UIViewController {
    
/* This is a regex that checks if it contains capital letters */
    
    open func containsUppercasedLetters(text: String) -> Bool {
        
        let capitalLetterRegEx = ".*[A-Z]+.*"
        let capitalizedTextTest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        
        if capitalizedTextTest.evaluate(with: text) {
            return true
        } else {
            return false
        }
    }
    
/* This is a regex that checks if it contains numbers */
    
    open func containsNumericCharacters(text: String) -> Bool {
        
        let numericRegEx = ".*[0-9]+.*"
        let numericTextTest = NSPredicate(format:"SELF MATCHES %@", numericRegEx)
        
        if numericTextTest.evaluate(with: text) {
            return true
        } else {
            return false
        }
    }
    
/* This is a regex that checks if it contains special characters */
    
    open func containsSpecialCharacters(text: String) -> Bool {
        
        let specialCharRegEx = ".*[\\^$*.\\[\\]\\\\{}()?\\-\"!@#%&/,><':;|_~`+=]+.*"
        let specialCharTextTest = NSPredicate(format: "SELF MATCHES %@", specialCharRegEx)
        
        if specialCharTextTest.evaluate(with: text) {
            return true
        } else {
            return false
        }
    }
    
/* This is a regex that checks if it contains lowercase letters */
    
    open func containsLowercasedCharacters(text: String) -> Bool {
        
        let normalLetterRegEx = ".*[a-z]+.*"
        let normalLetterTextTest = NSPredicate(format: "SELF MATCHES %@", normalLetterRegEx)
        
        if normalLetterTextTest.evaluate(with: text) {
            return true
        } else {
            return false
        }
    }
}
