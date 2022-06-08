//
//  String+Extension.swift
//  Restaurant
//
//  Created by Adji Firmansyah on 08/06/22.
//

import Foundation

extension String {
    func stringToURL(str: String) -> URL {
        let url = URL(string: str)!
        return url
    }
}
