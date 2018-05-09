//
//  ViewController.swift
//  GoliathBank
//
//  Created by Jared Perez Vega on 5/5/18.
//  Copyright © 2018 Jared Perez Vega. All rights reserved.
//

import UIKit

class ViewController: UIViewController, GBTableViewControllerProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: ViewToPresenterProtocol?
    private var data: GoliathBankModel!
    private var products = [String]()
    private var rates: GoliathBankModelRates!
    private var tableController: GBTableViewController!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.updateView()
    }

    private func setupTableView() {
        tableController = GBTableViewController(data: products)
        tableController.delegate = self
        let nib = UINib(nibName: "GBTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "GBTableViewCell")
        tableView.delegate = tableController
        tableView.dataSource = tableController
        tableView.rowHeight = 60.0
    }

    func goDetailView(id: String) {
        presenter?.goToDetailView(viewController: self, id: id, data: data, rates: rates)        
    }    
}

extension ViewController: PresenterToViewProtocol {
    
    func getRates(model: GoliathBankModelRates) {
        self.rates = model
        presenter?.updateCompletedView()
    }
    
    func getTransactions(model: GoliathBankModel) {
        self.data = model
        if let productList = presenter?.getProductList(model: model) {
            self.products = productList
            setupTableView()
        }
    }
    
    func showAlertView() {
        let alert = UIAlertController(title: "Alert", message: "Something is wrong", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
        }))
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { _ in
            self.presenter?.updateView()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

