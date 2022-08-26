//
//  HomeAbertaViewModel.swift
//  Bravve
//
//  Created by user218260 on 7/15/22.
//

import UIKit

class HomeOpenViewModel {
    
    init(_ customBarWithFilter: CustomBarWithFilter) {
        
        self.customBarWithFilter = customBarWithFilter
    }
    
    var delegate: HomeOpenViewModelProtocol?
    
    private let sessionManager = SessionManager()
    
    private let customBarWithFilter: CustomBarWithFilter
    
    func manageCustomBar() {
        
        let font = UIFont(name: FontsBravve.medium.rawValue,
                          size: CGFloat(15).generateSizeForScreen)
        
        let smallFont = UIFont(name: FontsBravve.light.rawValue,
                               size: CGFloat(11).generateSizeForScreen)
        
        var parameters = SpaceListParameters()
        
        sessionManager.getOpenDataArray (endpoint: .utilsStates){ (states: [States]?) in

            guard let states = states else {return}
            
            var stateButtons = [UIButton]()

            for state in states {

                let stateButton = UIButton()
                stateButton.setTitle(state.code, for: .normal)
                stateButton.setTitleColor(UIColor(named: ColorsBravve.label.rawValue),
                                     for: .normal)
                stateButton.titleLabel?.font = font
                let stateHandler = {(action: UIAction) in

                    self.customBarWithFilter.stateLabel.font = smallFont
                    self.customBarWithFilter.stateChosedLabel.text = stateButton.currentTitle
                    self.customBarWithFilter.cityChosedLabel.isHidden = true
                    self.customBarWithFilter.cityLabel.font = UIFont(name: FontsBravve.light.rawValue,
                                                                     size: CGFloat(15).generateSizeForScreen)
                    self.delegate?.reduceDropDowns()
                    
                    parameters = SpaceListParameters(space_state_id: state.id, space_city_id: nil, allow_workpass: nil, seats_qty: nil, space_type_id: nil, space_classification_id: nil, space_category_id: nil, space_facilities_id: nil, space_noise_level_id: nil, space_contract_Type: nil)
                    
                    self.customBarWithFilter.leftButton.isEnabled = false
                    self.customBarWithFilter.rightButton.isEnabled = false
                    
                    self.sessionManager.getOpenDataArray(id: "\(state.id)", endpoint: .utilsCities) { (cities: [Cities]?) in
                        
                        guard let cities = cities else {return}
                        
                        var cityButtons = [UIButton]()
                        
                        for city in cities {

                            let cityButton = UIButton()
                            cityButton.setTitle(city.name, for: .normal)
                            cityButton.setTitleColor(UIColor(named: ColorsBravve.label.rawValue),
                                                 for: .normal)
                            cityButton.titleLabel?.font = UIFont(name: FontsBravve.medium.rawValue,
                                                             size: CGFloat(15).generateSizeForScreen)
                            
                            self.customBarWithFilter.leftButton.isEnabled = true
                            self.customBarWithFilter.rightButton.isEnabled = true
                            
                            let cityHandler = {(action: UIAction) in
                                
                                self.customBarWithFilter.cityLabel.font = smallFont
                                self.customBarWithFilter.cityChosedLabel.text = cityButton.currentTitle
                                self.customBarWithFilter.cityChosedLabel.isHidden = false
                                self.delegate?.reduceDropDowns()
                            }
                            
                            cityButton.addAction(UIAction(handler: cityHandler), for: .touchUpInside)
                            cityButton.titleLabel?.constraintInsideTo(.leading, cityButton,
                                                                      CGFloat(15).generateSizeForScreen)
                            cityButtons.append(cityButton)
                        }
                        
                        self.delegate?.setupRightDropDown(cityButtons)
                    }
                }
                stateButton.addAction(UIAction(handler: stateHandler), for: .touchUpInside)
                stateButton.titleLabel?.constraintInsideTo(.leading, stateButton,
                                                           CGFloat(15).generateSizeForScreen)
                stateButtons.append(stateButton)
            }
            self.delegate?.setupLeftDropDown(stateButtons)
        }
        
        sessionManager.postDataWithOpenArrayResponse(endpoint: .spacesList, parameters: parameters) {(spaces: [Space]?) in
            
            guard let spaces = spaces else {return}
            
            self.delegate?.setSpaces(spaces)
            
            UIView.animate(withDuration: 0.6,
                           delay: 0.3) {

                self.delegate?.setCoverView(0)
            }
        }
    }
}

protocol HomeOpenViewModelProtocol {
    
    func setSpaces(_ spaces: [Space])
    
    func setCoverView(_ alpha: CGFloat)
    
    func reduceDropDowns()
    
    func setupLeftDropDown(_ buttons: [UIButton])
    
    func setupRightDropDown(_ buttons: [UIButton])
}