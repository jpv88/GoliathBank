//
//  DetailViewController.swift
//  GoliathBank
//
//  Created by Jared Perez Vega on 5/5/18.
//  Copyright © 2018 Jared Perez Vega. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var totalSum: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var presenter: ViewToPresenterProtocol?
    var data: GoliathBankModel!
    var rates: GoliathBankModelRates!    
    var identifier: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        totalSum.text = presenter?.setTotalTransactionsSum(data: data, rates: rates)
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "GBDetailTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "GBDetailTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60.0
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GBDetailTableViewCell") as? GBDetailTableViewCell else { return UITableViewCell() }
        cell.amountLabel.text = data[indexPath.row].amount
        cell.currencyLabel.text = data[indexPath.row].currency        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Elemento: \(data[indexPath.row])")
    }
}
