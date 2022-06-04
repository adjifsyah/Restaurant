//
//  RSTHomeTableViewController.swift
//  Restaurant
//
//  Created by Adji Firmansyah on 03/06/22.
//

import UIKit

class RSTHomeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        addDataRestaurant()
        
    }
    
    func registerCell() {
        tableView.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }
    
    private func addDataRestaurant() {
        let imagePlus: UIImage = UIImage(systemName: "plus") ?? UIImage()
        let add = UIBarButtonItem(image: imagePlus, style: .plain, target: self, action: #selector(addButton))
        navigationItem.rightBarButtonItem = add
    }

    @objc private func addButton() {
        print("Hide")
        tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier)?.isHidden = true
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        if row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier, for: indexPath) as? FormTableViewCell else { return UITableViewCell() }
            tableView.estimatedRowHeight = UITableView.automaticDimension
            tableView.rowHeight = 44
            tableView.estimatedRowHeight = UITableView.automaticDimension
            return cell
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }


}
