//
//  UIImage+Extension.swift
//  Restaurant
//
//  Created by Adji Firmansyah on 08/06/22.
//

import UIKit

extension UIImage {
    func loadImage(from url: URL) -> UIImage {
        var res: UIImage?
        let data = try? Data(contentsOf: url)
        res = UIImage(data: data ?? Data())
       
        return res ?? UIImage()
    }
    
}



