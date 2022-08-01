//
//  CGFloatExtension.swift
//  Teste
//
//  Created by Josicleison on 01/08/22.
//

import UIKit

extension UIViewController {
    
    open func generateFontSizeWithView() -> CGFloat {
        
        let width = UIScreen.main.bounds.width
        let device = UIScreen.main.traitCollection.userInterfaceIdiom
        
        if (device == .phone) {
            
            if (width <= 320) {
                
                // iPod(Gen7)
                // iPhone(5s, SEGen1)
                return 20 * 0.75
            }
            else if (width <= 375) {
                
                // iPhone(SEGen2 6, 6s, 7, 8, X, Xs, 11pro, 12mini, 13mini)
                return 20 * 0.95
            }
            else if (width <= 414) {
                
                // iPhone(6+, 6s+, 7+, 8+, XsMax, XR, 11, 11proMax, 12, 12pro, 13, 13pro)
                return 20
            }
            else if (width <= 744) {
                
                // iPhone(12proMax, 13proMax)
                return 20 * 1.2
            }
        }
        else if (device == .pad) {
            
            if (width <= 744) {
                
                // ipad(miniGen6, )
                return 20 * 1.4
            }
            else if (width <= 768) {
                
                // ipad(Gen5, Gen6, Air, Air2, Pro9.7)
                return 20 * 1.45
            }
            else if (width <= 810) {
                
                // ipad(Gen9)
                return 20 * 1.5
            }
            else if (width <= 834) {
                
                // ipad(AirGen3, AirGen5, Pro10.5, Pro11Gen1, Pro11Gen3)
                return 20 * 1.55
            }
            else if (width <= 1024) {
                
                // ipad(Pro12.9Gen1, Pro12.9Gen2, Pro12.9Gen3, Pro12.9Gen5)
                return 20 * 1.85
            }
        }
        
        return 20
    }
}

extension CGFloat {
    
    var dp: CGFloat {
        
        let width = UIScreen.main.bounds.width
        let device = UIScreen.main.traitCollection.userInterfaceIdiom
        
        if (device == .phone) {
            
            if (width <= 320) {
                // iPod(Gen7)
                // iPhone(5s, SEGen1)
                return self * 0.75
            } else if (width <= 375) {
                // iPhone(SEGen2 6, 6s, 7, 8, X, Xs, 11pro, 12mini, 13mini)
                return self * 0.95
            } else if (width <= 414) {
                // iPhone(6+, 6s+, 7+, 8+, XsMax, XR, 11, 11proMax, 12, 12pro, 13, 13pro)
                return self
            } else if (width <= 744) {
                // iPhone(12proMax, 13proMax)
                return self * 1.2
            }
        } else if (device == .pad) {
            if (width <= 744) {
                // ipad(miniGen6, )
                return self * 1.4
            } else if (width <= 768) {
                // ipad(Gen5, Gen6, Air, Air2, Pro9.7)
                return self * 1.45
            } else if (width <= 810) {
                // ipad(Gen9)
                return self * 1.5
            } else if (width <= 834) {
                // ipad(AirGen3, AirGen5, Pro10.5, Pro11Gen1, Pro11Gen3)
                return self * 1.55
            } else if (width <= 1024) {
                // ipad(Pro12.9Gen1, Pro12.9Gen2, Pro12.9Gen3, Pro12.9Gen5)
                return self * 1.85
            }
        }
        return self
    }
}