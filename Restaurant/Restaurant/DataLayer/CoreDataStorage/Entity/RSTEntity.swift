//
//  RSTEntity.swift
//  Restaurant
//
//  Created by Adji Firmansyah on 09/06/22.
//

import UIKit
import CoreData

class RSTEntity {
    static let shared = RSTEntity()
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    private init() { }
    
    func saveToCoreData(completion: @escaping (NSManagedObject) -> Void) {
        guard let context = appDelegate?.persistentContainer.viewContext else { return }
        
        let entity = NSEntityDescription.entity(forEntityName: "RestaurantData", in: context)
        let newRestaurant = NSManagedObject(entity: entity ?? NSEntityDescription(), insertInto: context)
        
        
        do {
            try context.save()

            completion(newRestaurant)
        } catch {
            print("Error Saving")
        }
        
    }
    
    func fetchLocalStorage(completion: @escaping ([NSManagedObject]) -> Void) {
        guard let context = appDelegate?.persistentContainer.viewContext else { return }
        let request: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RestaurantData")
        do {
            let res = try context.fetch(request) as? [NSManagedObject] ?? []
            completion(res)
        } catch {
            print("Error Saving")
        }
        
    }
    
    func isExist() {
//        let context = appDelegate?.persistentContainer.viewContext
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "RestaurantData")
//
//        do {
//
//        } catch {
//
//        }
    }
}
