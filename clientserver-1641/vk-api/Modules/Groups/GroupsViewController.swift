//
//  GroupsViewController.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 21.10.2021.
//

import UIKit

class GroupsViewController: UITableViewController {

    let groupsService = GroupsAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        groupsService.getGroups { groups in
            
            print("Получили группы в контроллере")
        }
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */
}
