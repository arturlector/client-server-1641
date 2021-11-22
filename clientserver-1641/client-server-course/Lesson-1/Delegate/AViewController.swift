//
//  AViewController.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 15.10.2021.
//

import UIKit

class AViewController: UIViewController, BViewControllerDelegate {
    
    @IBOutlet weak var alphabetLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func chooseAlphabetAction(_ sender: Any) {
        
        let bController = BViewController()
        bController.delegate = self //A - делегатом B
        
        navigationController?.pushViewController(bController, animated: true)
    }
    
    func alphabetChoosen(alphabet: String) {
        self.alphabetLabel.text = alphabet
    }
}
