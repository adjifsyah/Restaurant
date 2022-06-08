//
//  RSTHomeTableViewController.swift
//  Restaurant
//
//  Created by Adji Firmansyah on 03/06/22.
//

import UIKit
import CoreData
import SDWebImage

protocol RSTHomeDelegate {
    func getListOfRestaurant(completion: @escaping ([Restaurant]) -> Void)
}

class RSTHomeTableViewController: UITableViewController {
    var restaurantDisplayed: [Restaurant] = []
    
    override func viewWillAppear(_ animated: Bool) {
        print("MAIN viewWillAppear")
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "RestaurantData")
        request.returnsObjectsAsFaults = false
        do {
//            guard let result = try managedContext.fetch(request) as? [NSManagedObject] else { return }
//            for item in result {
//                managedContext.delete(item)
//            }
//           try managedContext.save()
            guard let result = try managedContext.fetch(request) as? [NSManagedObject] else { return }
            for data in result {
                let nameRestaurant    = data.value(forKey: "nameOfRestaurant") as? String
                let rating            = data.value(forKey: "ratingRestaurant") as? Float
                let descOfRestaurant  = data.value(forKey: "descOfRestaurant") as? String
                let favorite          = data.value(forKey: "favoriteMenu") as? String
                let imageURL          = data.value(forKey: "imageURL") as? String
                let videoURL          = data.value(forKey: "videoURL") as? String

                let restaurant = Restaurant(nameOfRestaurant: nameRestaurant,
                                            rating: rating,
                                            descRestaurant: descOfRestaurant,
                                            favoriteMenu: favorite,
                                            imageURL: imageURL,
                                            videoURL: videoURL)
                print("Restaurant", restaurant)
                restaurantDisplayed.append(restaurant)
                tableView.reloadData()
            }
        } catch {
            print("Error Fetch")
        }
        print("END MAIN viewWillAppear")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("data", restaurantDisplayed)
        registerCell()
        addDataRestaurant()
        
    }
    
    func registerCell() {
        tableView.register(RSTListTableViewCell.self, forCellReuseIdentifier: RSTListTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func addDataRestaurant() {
        let imagePlus: UIImage = UIImage(systemName: "plus") ?? UIImage()
        let add = UIBarButtonItem(image: imagePlus, style: .plain, target: self, action: #selector(addButton))
        navigationItem.rightBarButtonItem = add
    }
    
    @objc private func addButton() {
        let viewController = RSTFormViewController()
        viewController.view.backgroundColor = .white
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantDisplayed.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RSTListTableViewCell.identifier,
                                                       for: indexPath) as? RSTListTableViewCell
        else { return UITableViewCell() }
        
        let row = indexPath.row
        let restaurant = restaurantDisplayed[row]
        
        cell.containerView.backgroundColor = .gray
        cell.imageView?.sd_setImage(with: URL(string: restaurant.imageURL ?? ""), placeholderImage: UIImage(systemName: "photo"))
        cell.imageRestaurant.backgroundColor = .lightGray
        return cell
    }
}
