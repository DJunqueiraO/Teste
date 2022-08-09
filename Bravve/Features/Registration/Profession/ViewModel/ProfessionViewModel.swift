//
//  ProfissaoViewModel.swift
//  Bravve
//
//  Created by user218260 on 7/15/22.
//

import UIKit

class ProfessionViewModel {

    func selectAreaMenu(_ handler: @escaping UIActionHandler) -> [UIAction] {
            
            var selectAreaMenu: [UIAction] = []
            for i in 1...10 {
                selectAreaMenu.append(UIAction(title: "Trabalho \(i)" , handler: handler))
            }
            return selectAreaMenu
        }
    
    func workRegimeMenu(_ handler: @escaping UIActionHandler) -> [UIAction] {
            
        var workRegimeMenu: [UIAction] = []
        
        workRegimeMenu.append(UIAction(title: "Home Office", handler: handler))
        workRegimeMenu.append(UIAction(title: "Híbrido", handler: handler))
        workRegimeMenu.append(UIAction(title: "Presencial" , handler: handler))
        return workRegimeMenu
    }
}