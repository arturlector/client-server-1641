//
//  ViewController.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 15.10.2021.
//

import UIKit

class SendCashViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var cashTextField: UITextField!
    
    //Расшарили объект синглтон
    let account = Account.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func sendCashAction(_ sender: Any) {
        
        //оператор раннего выхода
        guard let cashString = cashTextField.text,
              let cash = Int(cashString),
              let name = nameTextField.text
        else {
            return
        }
        
        account.name = name
        account.cash = cash
        
    }
    
}

