//
//  BViewController.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 15.10.2021.
//

import UIKit

protocol BViewControllerDelegate: AnyObject {
    
    func alphabetChoosen(alphabet: String)
}

class BViewController: UITableViewController {

    weak var delegate: BViewControllerDelegate?
    
    let alphabets = ["A", "Б", "В", "Г", "Д"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return alphabets.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = alphabets[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alphabet = alphabets[indexPath.row]
        
        delegate?.alphabetChoosen(alphabet: alphabet)
        
        navigationController?.popViewController(animated: true)
    }
    

  

}
