//
//  NetworkConnection.swift
//  GoliathBank
//
//  Created by Jared Perez Vega on 5/5/18.
//  Copyright © 2018 Jared Perez Vega. All rights reserved.
//

import Foundation
import Alamofire

final class NetworkConnection: PresenterToInteractorProtocol {
    
    var presenter: InteractorToPresenterProtocol?
    
    var headers: HTTPHeaders = [
        "Content-Type":"application/json",
        "Accept": "application/json"
    ]
    
    func getAPIDataRates() {
        
        Alamofire.request(Constants.URLRatesEndpoint, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            if let status = response.response?.statusCode {
                switch(status){
                case 100...300:
                    if let json = response.result.value, let dictionary = json as? NSArray {
                        guard let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: JSONSerialization.WritingOptions.prettyPrinted) as Data else { return }
                        guard let goliathBankModelRates = try? JSONDecoder().decode(GoliathBankModelRates.self, from: jsonData) else { return }
                        self.presenter?.gettingRates(model: goliathBankModelRates)
                    }
                default:
                    self.presenter?.showError()
                }
            }
            
        }
    }
    
    func getAPIDataTransactions() {
        
        Alamofire.request(Constants.URLTransactionsEndpoint, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            if let status = response.response?.statusCode {
                switch(status){
                case 100...300:
                    if let json = response.result.value, let dictionary = json as? NSArray {
                        guard let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: JSONSerialization.WritingOptions.prettyPrinted) as Data else { return }
                        guard let goliathBankModel = try? JSONDecoder().decode(GoliathBankModel.self, from: jsonData) else { return }
                        self.presenter?.gettingTransactions(model: goliathBankModel)
                    }
                default:
                    self.presenter?.showError()
                }
            }
            
        }
    }
    
}
