//
//  NomeView.swift
//  Bravve
//
//  Created by user218260 on 7/15/22.
//

import UIKit

extension UIViewController {
    
    func createCapsuleButtons(_ buttonTitles: [String],
                              _ backgroundColor: UIColor = UIColor(named: "BlueBravve") ?? UIColor()) -> [UIButton] {
        
        var buttons: [UIButton] = []
        
        for title in buttonTitles {
            
            let button = UIButton()
            button.setToDefaultCapsuleButton(title, backgroundColor)
            
            buttons.append(button)
        }
        
        return buttons
    }
    
    open func createProgressBarButtons(_ buttonImageNames: [String]) -> [UIButton] {
        
        var buttons: [UIButton] = []
        
        for name in buttonImageNames {
            
            let button = UIButton()
            button.setToProgressBarButtonDefault(name)
            
            buttons.append(button)
        }
        
        return buttons
    }
}

extension UIView {
    
    open func createSuperStackView(_ arrangedSubviews: [UIView]) {
        
        self.layer.cornerRadius = 8
        
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.spacing = 15
        stackView.layer.cornerRadius = 8
        stackView.backgroundColor = .yellow
        
        self.addSubview(stackView)
        
        stackView.constraintInsideTo(.top, self, -1)
        stackView.constraintInsideTo(.leading, self)
        stackView.constraintInsideTo(.trailing, self)
        stackView.constraintInsideTo(.bottom, self, 1)
    }
}

extension UIButton {
    
    open func setMenuForButton(_ menuItens: [UIAction]) {
        
        self.setImage(UIImage(named: "downButtonBlue"), for: .normal)
        self.tintColor = .systemBlue
        self.menu = UIMenu(children: menuItens)
        self.showsMenuAsPrimaryAction = true
        self.changesSelectionAsPrimaryAction = true
    }
}

extension UIViewController {
    
    open func isIpad() -> Bool {
        
        if UIScreen.main.traitCollection.horizontalSizeClass == .regular {
            
            return true
        }
        return false
    }
}

extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        
        for view in views {
            
            self.addSubview(view)
        }
    }
}

extension UIStackView {
    
    func addArrangedSubviews(_ views: [UIView]) {
        
        for view in views {
            
            self.addArrangedSubview(view)
        }
    }
}

extension UIView {

    func addBottomLineWithColor(color: UIColor = .gray, width: CGFloat = 0.8, y: CGFloat = 0) {

        let bottomBorderLine = CALayer()
        bottomBorderLine.backgroundColor = color.cgColor
        bottomBorderLine.frame = CGRect(x: 0,
                                        y: self.frame.size.height - width + y,
                                        width: self.frame.size.width,
                                        height: width)

        self.layer.addSublayer(bottomBorderLine)
    }
    
    func addLeadingLineWithColor(color: UIColor = .gray, height: CGFloat = 0.8, x: CGFloat = 0) {

        let leadingBorderLine = CALayer()
        leadingBorderLine.backgroundColor = color.cgColor
        leadingBorderLine.frame = CGRect(x: self.frame.size.width - height + x,
                                        y: 0,
                                        width: self.frame.size.height,
                                        height: height)

        self.layer.addSublayer(leadingBorderLine)
    }
}
