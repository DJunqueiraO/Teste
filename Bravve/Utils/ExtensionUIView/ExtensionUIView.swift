//
//  ExtensionUIView.swift
//  Bravve
//
//  Created by Evandro Rodrigo Minamoto on 28/07/22.
//

import UIKit

//Extensions related to default elements
extension UIView {
    
    open func setToDefaultBackgroundColor() {
        
        self.backgroundColor = .white
    }
    
    open func setToDefaultCustomBarWithBackButton(viewTitle: String, _ handler: @escaping UIActionHandler) {
        
        self.backgroundColor = UIColor(named: "BlueBravve")
        
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "backButtonWhite"), for: .normal)
        
        backButton.addAction(UIAction(handler: handler), for: .touchUpInside)
        
        let titleLabel = UILabel()
        titleLabel.text = viewTitle
        titleLabel.font = UIFont(name: "Ubuntu-Medium", size: 19)
        titleLabel.textColor = .white
        
        self.addSubviews([backButton, titleLabel])
        
        backButton.constraintInsideTo(.centerY, self)
        backButton.constraintInsideTo(.leading, self, 35)
        backButton.sizeAnchorInSuperview(50)
        
        titleLabel.constraintInsideTo(.centerY, self)
        titleLabel.constraintInsideTo(.centerX, self)
        
        self.constraintInsideTo(.top, superview)
        self.constraintInsideTo(.leading, superview?.safeAreaLayoutGuide)
        self.constraintInsideTo(.trailing, superview?.safeAreaLayoutGuide)
        self.heightAnchorInSuperview(144)
    }
    
    open func setToDefaultCustomBarWithFilter() {
        
        self.backgroundColor = UIColor(named: "BlueBravve")
        
        let leftButton = UIButton()
        let stateLabel = UILabel()
        let stateChosedLabel = UILabel()
        let rightButton = UIButton()
        let cityLabel = UILabel()
        let cityChosedLabel = UILabel()
        
        let stateHandler = {(action: UIAction) in

            stateChosedLabel.text = action.title
            stateLabel.font = UIFont(name: "Ubuntu-Light", size: 11)
        }

        stateLabel.text = "UF"
        leftButton.setMenuForButton([
            
            UIAction(title: "action1",handler: stateHandler),
            UIAction(title: "action2",handler: stateHandler)

        ])
        leftButton.setTitle("", for: .normal)
        
        let cityHandler = {(action: UIAction) in

            cityChosedLabel.text = action.title
            cityLabel.font = UIFont(name: "Ubuntu-Light", size: 11)
        }
        
        cityLabel.text = "Cidade"
        rightButton.setMenuForButton([

            UIAction(title: "action1",handler: cityHandler),
            UIAction(title: "action2",handler: cityHandler)

        ])
        rightButton.setTitle("", for: .normal)
        
        let leftStackView = UIStackView(arrangedSubviews: [stateLabel,
                                                           stateChosedLabel])
        leftStackView.axis = .vertical
        let rightStackView = UIStackView(arrangedSubviews: [cityLabel,
                                                            cityChosedLabel])
        rightStackView.axis = .vertical
        
        let stackView = UIStackView()
        
        stackView.addArrangedSubviews([leftStackView, leftButton, rightStackView, rightButton])
        
        leftStackView.constraintInsideTo(.width, stackView, multiplier: 0.2)
        leftButton.constraintInsideTo(.width, stackView, multiplier: 0.1)
        rightButton.constraintInsideTo(.width, stackView, multiplier: 0.1)
        
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 8
        stackView.setToDefaultBackgroundColor()
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10,
                                               left: 10,
                                               bottom: 10,
                                               right: 10)
        
        let filterButton = UIButton()
        filterButton.setImage(UIImage(named: "Filter-2"), for: .normal)
        
        self.addSubviews([filterButton, stackView])
        
        stackView.constraintInsideTo(.centerY, self)
        stackView.constraintInsideTo(.leading, self, 20)
        stackView.constraintOutsideTo(.trailing, filterButton, 20)
        
        filterButton.constraintInsideTo(.centerY, self)
        filterButton.constraintInsideTo(.trailing, self, 20)
        filterButton.sizeAnchorInSuperview(50)
        
        let titleLabel = UILabel()
        titleLabel.text = "Espaço"
        titleLabel.font = UIFont(name: "Ubuntu-Medium", size: 19)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        
        self.constraintInsideTo(.top, superview?.safeAreaLayoutGuide)
        self.constraintInsideTo(.leading, superview?.safeAreaLayoutGuide)
        self.constraintInsideTo(.trailing, superview?.safeAreaLayoutGuide)
        self.heightAnchorInSuperview(100)
    }
}

//Extensions related to creation of elements
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

//Extensions related to constraints
extension UIView {
    
    open func heightAnchorInSuperview(_ constant: CGFloat = 32) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        superview?.addConstraint(self.heightAnchor.constraint(equalToConstant: constant))
    }
    
    open func widthAnchorInSuperview(_ constant: CGFloat = 32) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        superview?.addConstraint(self.widthAnchor.constraint(equalToConstant: constant))
    }
    
    open func sizeAnchorInSuperview(_ constant: CGFloat = 32) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        superview?.addConstraints([
        
            self.heightAnchor.constraint(equalToConstant: constant),
            self.widthAnchor.constraint(equalToConstant: constant)
        ])
    }
    
    open func fillSuperview(_ constant: CGFloat = 0) {
        
        self.constraintInsideTo(.top, superview?.safeAreaLayoutGuide, constant)
        self.constraintInsideTo(.leading, superview?.safeAreaLayoutGuide, constant)
        self.constraintInsideTo(.trailing, superview?.safeAreaLayoutGuide, constant)
        self.constraintInsideTo(.bottom, superview?.safeAreaLayoutGuide, constant)
    }
    
    open func constraintTo(_ attribute: NSLayoutConstraint.Attribute,
                           _ toItem: Any?,
                           _ constant: CGFloat = 0,
                           multiplier: CGFloat = 1) {
        
        superview?.addConstraint(NSLayoutConstraint(item: self,
                                                    attribute: attribute,
                                                    relatedBy: .equal,
                                                    toItem: toItem,
                                                    attribute: attribute,
                                                    multiplier: multiplier,
                                                    constant: constant))
    }
        
    open func constraintInsideTo(_ attribute: NSLayoutConstraint.Attribute,
                                 _ toItem: Any?,
                                 _ constant: CGFloat = 0,
                                 multiplier: CGFloat = 1) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if attribute == .bottom || attribute == .trailing {
            
            superview?.addConstraint(NSLayoutConstraint(item: self,
                                                        attribute: attribute,
                                                        relatedBy: .equal,
                                                        toItem: toItem,
                                                        attribute: attribute,
                                                        multiplier: multiplier,
                                                        constant: -constant))
        }
        
        superview?.addConstraint(NSLayoutConstraint(item: self,
                                                    attribute: attribute,
                                                    relatedBy: .equal,
                                                    toItem: toItem,
                                                    attribute: attribute,
                                                    multiplier: multiplier,
                                                    constant: constant))
    }
    
    open func constraintOutsideTo(_ attribute: NSLayoutConstraint.Attribute,
                                  _ toItem: Any?,
                                  _ constant: CGFloat = 0,
                                  multiplier: CGFloat = 1) {
         
        translatesAutoresizingMaskIntoConstraints = false
        
        let itemAttribute: NSLayoutConstraint.Attribute
        
        switch attribute {
            
            case .top: itemAttribute = .bottom
            case .trailing: itemAttribute = .leading
            case .leading: itemAttribute = .trailing
            case .bottom: itemAttribute = .top
            default: itemAttribute = attribute
        }
        
        if attribute == .bottom || attribute == .trailing {
            
            superview?.addConstraint(NSLayoutConstraint(item: self,
                                                        attribute: attribute,
                                                        relatedBy: .equal,
                                                        toItem: toItem,
                                                        attribute: itemAttribute,
                                                        multiplier: multiplier,
                                                        constant: -constant))
        }
        
        superview?.addConstraint(NSLayoutConstraint(item: self,
                                                    attribute: attribute,
                                                    relatedBy: .equal,
                                                    toItem: toItem,
                                                    attribute: itemAttribute,
                                                    multiplier: multiplier,
                                                    constant: constant))
    }
}

//Extensions to add multiple Subviews on a view
extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        
        for view in views {
            
            self.addSubview(view)
        }
    }
}
