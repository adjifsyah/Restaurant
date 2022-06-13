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
    var localStorage: RSTEntity = .shared
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
        fetchCoreData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        addDataRestaurant()
        
    }
    
    func fetchCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "RestaurantData")
        do {
            guard let result = try managedContext.fetch(request) as? [NSManagedObject] else { return }
            restaurantDisplayed = []
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
            
        }
    }
    
    private func configureView() {
        title = "Restaurant"
        view.backgroundColor = .secondarySystemBackground
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
                                                       for: indexPath) as? RSTListTableViewCell else
        { return UITableViewCell() }
        let row = indexPath.row
        let data = restaurantDisplayed[row]
        
        cell.imageRestaurant.sd_setImage(with: URL(string: data.imageURL ?? ""), placeholderImage: UIImage(systemName: "photo"))
        cell.nameOfRestaurant.text = data.nameOfRestaurant
        cell.ratingOfRestaurant.text = String(describing: data.rating ?? 0.0)
        cell.imageRestaurant.backgroundColor = .lightGray
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        let data = restaurantDisplayed[row]
        let vc = DetailViewController()
        let imageURL = URL(string: data.imageURL ?? "")
        let placeholderImage = UIImage(systemName: "photo")
        vc.view.backgroundColor = .white
        vc.imageRestaurant.sd_setImage(with: imageURL, placeholderImage: placeholderImage)
        vc.nameOfRestaurant.text = data.nameOfRestaurant
        vc.ratingOfRestaurant.text = String(describing: data.rating ?? 0.0)
        vc.descriptionOfRestaurant.text = data.descRestaurant
        navigationController?.pushViewController(vc, animated: true)
    }
}
