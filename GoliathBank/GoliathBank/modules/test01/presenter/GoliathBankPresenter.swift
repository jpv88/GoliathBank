//
//  GoliathBankPresenter.swift
//  GoliathBank
//
//  Created by Jared Perez Vega on 8/5/18.
//  Copyright © 2018 Jared Perez Vega. All rights reserved.
//

import UIKit

class GoliathBankPresenter: ViewToPresenterProtocol {
    
    var view: PresenterToViewProtocol?
    var interactor: PresenterToInteractorProtocol?
    var router: PresenterToRouterProtocol?

    func updateView() {
        interactor?.getAPIDataRates()
    }
    
    func updateCompletedView() {
        interactor?.getAPIDataTransactions()
    }
    
    func getProductList(model: GoliathBankModel) -> [String] {
        var elements = ""
        for item in model {
            if !elements.contains(item.sku) {
                elements += item.sku + "|"
            }
        }
        var result = elements.components(separatedBy: "|")
        result.removeLast()
        return result
    }
    
    func goToDetailView(viewController: UIViewController, id: String, data: GoliathBankModel, rates: GoliathBankModelRates) {        
        if let viewControllerDetail = viewController.storyboard?.instantiateViewController(withIdentifier: "DetailViewController"), let vc = viewControllerDetail as? DetailViewController {
            vc.data = data.filter { $0.sku == id }
            vc.identifier = id
            vc.rates = rates
            vc.presenter = self
            router?.pushFromVCToVC(from: viewController, to: vc)            
        }
    }
    
    func setTotalTransactionsSum(data: GoliathBankModel, rates: GoliathBankModelRates) -> String {
        var result: Float = 0.0
        for item in data {
            if item.currency == "EUR" {
                result += Utils.getAmount(item.amount)
            } else {
                let filteredRates = rates.filter { $0.from == item.currency && $0.to == "EUR" }
                if filteredRates.count > 0 {
                    result += Utils.getAmount(item.amount) * Utils.getAmount(filteredRates[0].rate)
                } else {
                    let filtered = rates.filter { $0.from == item.currency}
                    if filtered.count > 0 {
                        let accumulated = filtered[0].rate
                        let newFilter = rates.filter { $0.from == filtered[0].to && $0.to == "EUR" }
                        if newFilter.count > 0 {
                            result += Utils.getAmount(item.amount) * Utils.getAmount(newFilter[0].rate) * Utils.getAmount(accumulated)
                        }
                    }
                }
            }
        }
        return "\(result) €"
    }
}

extension GoliathBankPresenter: InteractorToPresenterProtocol {
    func showError() {
        self.view?.showAlertView()
    }
    
    func gettingRates(model: GoliathBankModelRates) {
        self.view?.getRates(model: model)
    }
    
    func gettingTransactions(model: GoliathBankModel) {
        self.view?.getTransactions(model: model)
    }
}


