//
//  GoliathBankModelRates.swift
//  GoliathBank
//
//  Created by Jared Perez Vega on 5/5/18.
//  Copyright © 2018 Jared Perez Vega. All rights reserved.
//

import Foundation

typealias GoliathBankModelRates = [GoliathBankModelRate]

struct GoliathBankModelRate: Codable {
    let from, to, rate: String
}
