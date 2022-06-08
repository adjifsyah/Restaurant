//
//  RSTListTableViewCell.swift
//  Restaurant
//
//  Created by Adji Firmansyah on 06/06/22.
//

import UIKit

class RSTListTableViewCell: UITableViewCell {
    static let identifier = "listCell"
    lazy var containerView: UIView = UIView()
    
    lazy var imageRestaurant: UIImageView = {
        var imageRestaurant = UIImageView()
        imageRestaurant.contentMode = .scaleAspectFill
        imageRestaurant.clipsToBounds = true
        return imageRestaurant
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubview() {
        self.addSubview(containerView)
        containerView.addSubview(imageRestaurant)
    }
    
    private func setupConstraint() {
        imageRestaurant.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        imageRestaurant.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        imageRestaurant.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
        imageRestaurant.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
        imageRestaurant.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        
        
    }

}
