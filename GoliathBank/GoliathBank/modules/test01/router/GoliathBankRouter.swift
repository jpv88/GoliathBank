//
//  GoliathBankRouter.swift
//  GoliathBank
//
//  Created by Jared Perez Vega on 8/5/18.
//  Copyright © 2018 Jared Perez Vega. All rights reserved.
//

import UIKit

class GoliathBankRouter: PresenterToRouterProtocol {
    
    func pushFromVCToVC(from: UIViewController, to: UIViewController) {
        from.navigationController?.pushViewController(to, animated: true)
    }
    
    static func createModule(view: UIViewController) {
        if let view = view as? ViewController {
            
            let presenter = GoliathBankPresenter()
            let interactor = NetworkConnection()
            let router = GoliathBankRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
        }
    }
    
    
}
