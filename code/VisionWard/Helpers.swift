//
//  Helpers.swift
//  VisionWard
//
//  Created by Andreas Felder on 25.09.2025.
//

import Foundation
import UIKit

extension UIDevice {
    static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isIPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
}
