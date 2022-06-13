//
//  UIImageView+Extension.swift
//  Restaurant
//
//  Created by Adji Firmansyah on 08/06/22.
//

import UIKit

extension UIImageView {
    func loadImage(resource: URL?) {
        guard let resource = resource else { return }
        DispatchQueue.global(qos: .background).async {
            guard let data = try? Data(contentsOf: resource) else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
                self.backgroundColor = .white
            }
        }
    }
    
    func loadImage(resource: String?) {
        backgroundColor = .secondarySystemBackground
        guard let resource = resource, let url = URL(string: resource) else {
            backgroundColor = .white
            return
        }
        loadImage(resource: url)
    }
    
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.image = UIImage(data: data)
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
