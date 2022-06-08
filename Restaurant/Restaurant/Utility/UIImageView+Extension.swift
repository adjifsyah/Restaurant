//
//  UIImageView+Extension.swift
//  Restaurant
//
//  Created by Adji Firmansyah on 08/06/22.
//

import UIKit

extension UIImageView {
    func loadImage(from urlString: String?) {
        guard let imageURLString = urlString else {
            print("Extennsion", urlString)
            self.image = UIImage(systemName: "photo")
            return
        }
        print("Extennsion passed", urlString)
        DispatchQueue.global().async { [weak self] in
            let data = try? Data(contentsOf: URL(string: imageURLString) ?? URL(fileURLWithPath: urlString ?? ""))
            DispatchQueue.main.async {
                self?.image = data != nil ? UIImage(data: data!) : UIImage(systemName: "photo")
            }
        }
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
