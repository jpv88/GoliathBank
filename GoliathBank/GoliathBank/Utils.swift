//
//  Utils.swift
//  GoliathBank
//
//  Created by Jared Perez Vega on 8/5/18.
//  Copyright © 2018 Jared Perez Vega. All rights reserved.
//

import Foundation

final class Utils {
    
    class func getAmount(_ str: String) -> Float {
        let numberFormatter = NumberFormatter()
        let number = numberFormatter.number(from: str)
        if let numberFloatValue = number?.floatValue {
            return numberFloatValue
        }
        return 0
    }
}
