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
    
    lazy var imageRating: UIImageView = {
        var imageRestaurant = UIImageView()
        imageRestaurant.image = UIImage(systemName: "star.fill")
        imageRestaurant.tintColor = .orange
        imageRestaurant.contentMode = .scaleAspectFit
        imageRestaurant.clipsToBounds = true
        return imageRestaurant
    }()
    
    lazy var nameOfRestaurant: UILabel = {
        var nameOfRestaurant = UILabel()
        nameOfRestaurant.font = .systemFont(ofSize: 16, weight: .bold)
        nameOfRestaurant.textColor = .black
        return nameOfRestaurant
    }()
    
    lazy var ratingOfRestaurant: UILabel = {
        var nameOfRestaurant = UILabel()
        nameOfRestaurant.font = .systemFont(ofSize: 16, weight: .regular)
        nameOfRestaurant.textColor = .black
        return nameOfRestaurant
    }()
    
    lazy var ratingSV: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [imageRating, ratingOfRestaurant])
        stackView.axis = .horizontal
        stackView.spacing = 1
        return stackView
    }()
    
    lazy var topTitleSV: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [nameOfRestaurant, ratingSV])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
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
        containerView.backgroundColor = .white
        self.addSubview(containerView)
        containerView.addSubview(imageRestaurant)
        containerView.addSubview(topTitleSV)
    }
    
    private func setupConstraint() {
        imageRestaurant.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        topTitleSV.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        
        imageRestaurant.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        imageRestaurant.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
        imageRestaurant.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
        imageRestaurant.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        topTitleSV.topAnchor.constraint(equalTo: imageRestaurant.bottomAnchor, constant: 8).isActive = true
        topTitleSV.leadingAnchor.constraint(equalTo: imageRestaurant.leadingAnchor).isActive = true
        topTitleSV.trailingAnchor.constraint(equalTo: imageRestaurant.trailingAnchor).isActive = true
        topTitleSV.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8).isActive = true
    }

}
