//
//  CombineChainAPITableViewController.swift
//  CombineExampleUIKit
//
//  Created by Oleg Ten on 07/07/2022.
//

import UIKit
import Combine

class CombineChainAPITableViewController: UITableViewController {

    
    let viewModel = ViewModel()
    var comments: [Comment] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.fetchComments { comments in
            self.comments = comments
        }
    
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return comments.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = comments[indexPath.row].email
        cell.detailTextLabel?.text = comments[indexPath.row].name

        return cell
    }
}






