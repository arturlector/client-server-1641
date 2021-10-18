//
//  FriendsViewController.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 18.10.2021.
//

import UIKit

class FriendsViewController: UITableViewController {

    let friendsService = FriendsAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        friendsService.getFriends { friends in
            
            print("Получили друзей в контроллере")
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
