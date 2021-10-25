//
//  FriendsViewController.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 18.10.2021.
//

import UIKit

class FriendsViewController: UITableViewController {

    let friendsService = FriendsAPI()
    
    var friends: [FriendDB] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
      
//        friendsService.getFriends { [weak self] friends in
//
//            //нужно ли чтобы кложур выполнил работу если контроллер обнулился (вылетел из памяти)
//            guard let self = self else { return }
//
//            print("Получили друзей в контроллере")
//
//            self.friends = friends
//            self.tableView.reloadData()
//        }
        
//            friendsService.getFriends2 { [weak self] friends in
//                self?.friends = friends
//                self?.tableView.reloadData()
//            }
        
//        friendsService.getFriends3 { [weak self] friends in
//            self?.friends = friends
//            self?.tableView.reloadData()
//        }
        
        friendsService.getFriends4 { [weak self] friends in
            self?.friends = friends
            self?.tableView.reloadData()
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let friend = friends[indexPath.row]
        cell.textLabel?.text = friend.fullName
        
        return cell
    }
    
}
