//
//  DetailViewController.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 15.10.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cashLabel: UILabel!
    
    let account = Account.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = account.name
        cashLabel.text = String(account.cash)
    }
    


}
