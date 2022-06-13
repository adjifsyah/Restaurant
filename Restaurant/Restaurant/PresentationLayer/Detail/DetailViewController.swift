//
//  DetailViewController.swift
//  Restaurant
//
//  Created by Adji Firmansyah on 10/06/22.
//

import UIKit

class DetailViewController: UIViewController {
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
        nameOfRestaurant.font = .systemFont(ofSize: 20, weight: .bold)
        nameOfRestaurant.textColor = .black
        return nameOfRestaurant
    }()
    
    lazy var ratingOfRestaurant: UILabel = {
        var nameOfRestaurant = UILabel()
        nameOfRestaurant.font = .systemFont(ofSize: 20, weight: .regular)
        nameOfRestaurant.textColor = .black
        return nameOfRestaurant
    }()
    
    lazy var descriptionOfRestaurant: UILabel = {
        var nameOfRestaurant = UILabel()
        nameOfRestaurant.font = .systemFont(ofSize: 14, weight: .regular)
        nameOfRestaurant.textColor = .black
        nameOfRestaurant.numberOfLines = 1
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
    
    lazy var titleStackView: UIStackView = {
        var titleSV = UIStackView(arrangedSubviews: [topTitleSV, descriptionOfRestaurant])
        titleSV.axis = .vertical
        titleSV.spacing = 16
        return titleSV
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        setupConstraint()
    }
    
    func addSubview() {
        view.addSubview(imageRestaurant)
        view.addSubview(titleStackView)
    }
    
    func setupConstraint() {
        imageRestaurant.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        
        imageRestaurant.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        imageRestaurant.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageRestaurant.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageRestaurant.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        titleStackView.topAnchor.constraint(equalTo: imageRestaurant.bottomAnchor, constant: 8).isActive = true
        titleStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        titleStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
    }

}
