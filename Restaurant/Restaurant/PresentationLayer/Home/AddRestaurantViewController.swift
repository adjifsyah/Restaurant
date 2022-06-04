//
//  AddRestaurantViewController.swift
//  Restaurant
//
//  Created by Adji Firmansyah on 04/06/22.
//

import UIKit

class AddRestaurantViewController: UIViewController {
    lazy var nameOfResto: FormTextField = {
        var nameOfResto = FormTextField()
        nameOfResto.configure(placeholder: "Name restaurant")
        nameOfResto.setHeight = 40
        nameOfResto.setMargin = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: -16)
//        nameOfResto.backgroundColor = .white
        return nameOfResto
    }()
    
    lazy var ratingOfResto: FormTextField = {
        var ratingOfResto = FormTextField()
        ratingOfResto.configure(placeholder: "Rating restaurant")
        ratingOfResto.setHeight = 40
        ratingOfResto.setMargin = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: -16)
        
        return ratingOfResto
    }()
    
    lazy var descriptionOfResto: FormTextField = {
        var descriptionOfResto = FormTextField()
        descriptionOfResto.configure(placeholder: "Description")
        descriptionOfResto.setHeight = 40
        descriptionOfResto.setMargin = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: -16)
        
        return descriptionOfResto
    }()
    
    lazy var menuFavorite: FormTextField = {
        var menuFavorite = FormTextField()
        menuFavorite.configure(placeholder: "Favorite menu")
        menuFavorite.setHeight = 40
        menuFavorite.setMargin = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: -16)
        return menuFavorite
    }()
    
    private lazy var formStackView: UIStackView = {
        var formStackView = UIStackView(
            arrangedSubviews: [
                nameOfResto,
                ratingOfResto,
                descriptionOfResto,
                menuFavorite
            ])
        formStackView.axis = .vertical
        formStackView.spacing = 8
        formStackView.backgroundColor = .white
        return formStackView
    }()
    
    private lazy var mediaStackView: UIStackView = {
        var mediaStackView = UIStackView(
            arrangedSubviews: [ ])
        mediaStackView.axis = .vertical
        mediaStackView.spacing = 8
        mediaStackView.backgroundColor = .white
        return mediaStackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .secondarySystemBackground
        
        configureView()
        setupNavigation()
        setupConstraint()
    }
    
    func configureView() {
        view.addSubview(formStackView)
    }
    
    private func setupNavigation() {
        title = "Add Restaurant"
        let saveButtonView = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveAction))
        let cancelButtonView = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelAction))
        
        navigationItem.rightBarButtonItem = saveButtonView
        navigationItem.leftBarButtonItem = cancelButtonView
    }
    
    @objc private func saveAction() {
        print("Save")
    }
    
    @objc private func cancelAction() {
        print("Save")
    }
    
    private func setupConstraint() {
        formStackView.translatesAutoresizingMaskIntoConstraints = false
        formStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        formStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        formStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
    }
    
}
