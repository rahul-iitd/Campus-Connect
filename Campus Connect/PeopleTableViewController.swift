//
//  PeopleTableViewController.swift
//  Campus Connect
//
//  Created by Rahul Bansal on 01/03/20.
//  Copyright © 2020 Rahul Bansal. All rights reserved.
//

import UIKit

class PeopleTableViewController: UITableViewController, UISearchResultsUpdating {
	
    var users: [User] = []
    var searchController: UISearchController = UISearchController(searchResultsController: nil)
    var serachResults : [User] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSerachBarController()
        setupNavigationBar()
        observeUsers()
        setupTableView()
        
    }
    func setupTableView(){
        tableView.tableFooterView = UIView()
    }
    
    func setupSerachBarController(){
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search Users..."
        searchController.searchBar.barTintColor = UIColor.white
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    func setupNavigationBar(){
        navigationItem.title = "People"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func observeUsers(){
        Api.user.observeUsers { (user) in
            self.users.append(user)
            self.tableView.reloadData()
        }
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
       if searchController.searchBar.text == nil || searchController.searchBar.text!.isEmpty
        {
           view.endEditing(true)
       }else{
        	let textLowerCased = searchController.searchBar.text!.lowercased()
        	filterContent(for:textLowerCased)
        }
        tableView.reloadData()
    }
	
    func filterContent(for serachText: String){
        serachResults = self.users.filter {
            return $0.username.lowercased().range(of: serachText) != nil
        }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive{
            return serachResults.count
        }
        else{return self.users.count}
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell

    //     Configure the cell...
        let user = searchController.isActive ? serachResults[indexPath.row] : users[indexPath.row]
        cell.loadData(user)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
    }
 	
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? UserTableViewCell{
            let storyborad = UIStoryboard(name: "Welcome", bundle: nil)
            let chatVC = storyborad.instantiateViewController(withIdentifier: "ChatVC") as! ChatViewController
            chatVC.imagePartner = cell.avatar.image
            chatVC.partnerUsername = cell.usernameLbl.text
            chatVC.partnerId = cell.user.uid
            self.navigationController?.pushViewController(chatVC, animated: true)
        }
        
    }

    
}
