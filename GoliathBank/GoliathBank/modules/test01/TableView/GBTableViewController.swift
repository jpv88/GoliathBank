//
//  GBTableViewController.swift
//  GoliathBank
//
//  Created by Jared Perez Vega on 5/5/18.
//  Copyright © 2018 Jared Perez Vega. All rights reserved.
//

import UIKit

protocol GBTableViewControllerProtocol {
    func goDetailView(id: String)
}

class GBTableViewController: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var delegate:GBTableViewControllerProtocol?
    
    var data: [String]!
    
    var products = [String]()
    
    convenience init(data: [String]) {
        self.init()
        
        self.data = data
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GBTableViewCell") as? GBTableViewCell else { return UITableViewCell() }
        cell.idLabel.text = data[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.goDetailView(id: data[indexPath.row])
    }
    
    
}
