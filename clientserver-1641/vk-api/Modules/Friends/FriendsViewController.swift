//
//  FriendsViewController.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 18.10.2021.
//

import UIKit
import RealmSwift

class FriendsViewController: UITableViewController {
    
    //Services
    private let friendsAPI = FriendsAPI()
    private let friendsDB = FriendsDB()
    
    //Datasource
    private var friends: Results<FriendModel>?
    private var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        friendsAPI.getFriends4 { [weak self] friends in
            guard let self = self else { return }
            
            self.friendsDB.save(friends)
            self.friends = self.friendsDB.load()
// - ДЗ 6 урок
//            self.tableView.reloadData()
// - ДЗ 7 урок
            self.token = self.friends?.observe { [weak self] changes in
                guard let self = self else { return }

                switch changes {
                case .initial:
                    self.tableView.reloadData()
                case .update(_, let deletions, let insertions, let modifications):
                    self.tableView.beginUpdates()
                    self.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                    self.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                    self.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                    self.tableView.endUpdates()
                case .error(let error):
                    fatalError("\(error)")
                }
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let friends = friends else { return 0 }
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let friend = friends?[indexPath.row]
        
        cell.textLabel?.text = friend?.fullName
        
        if let imageUrl = URL(string:friend?.photo100 ?? "") {
            cell.imageView?.load(url: imageUrl)
        }
        
        return cell
    }
    
}
