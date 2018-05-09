//
//  GoliathBankProtocols.swift
//  GoliathBank
//
//  Created by Jared Perez Vega on 8/5/18.
//  Copyright © 2018 Jared Perez Vega. All rights reserved.
//

import UIKit

protocol ViewToPresenterProtocol: class {
    var view: PresenterToViewProtocol? { get set }
    var interactor: PresenterToInteractorProtocol? { get set }
    var router: PresenterToRouterProtocol? { get set }
    func updateView()
    func updateCompletedView()
    func getProductList(model: GoliathBankModel) -> [String]
    func setTotalTransactionsSum(data: GoliathBankModel, rates: GoliathBankModelRates) -> String
    func goToDetailView(viewController: UIViewController, id: String, data: GoliathBankModel, rates: GoliathBankModelRates)
}

protocol PresenterToViewProtocol: class {
    func showAlertView()
    func getRates(model: GoliathBankModelRates)
    func getTransactions(model: GoliathBankModel)
}

protocol PresenterToInteractorProtocol: class {
    func getAPIDataRates()
    func getAPIDataTransactions()
}

protocol InteractorToPresenterProtocol: class {
    func gettingRates(model: GoliathBankModelRates)
    func gettingTransactions(model: GoliathBankModel)
    func showError()        
}

protocol PresenterToRouterProtocol: class {
    static func createModule(view: UIViewController)
    func pushFromVCToVC(from: UIViewController, to: UIViewController)        
}
