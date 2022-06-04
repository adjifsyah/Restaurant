//
//  FormTableViewCell.swift
//  Restaurant
//
//  Created by Adji Firmansyah on 04/06/22.
//

import UIKit

class FormTableViewCell: UITableViewCell {
    static let identifier = "formCell"
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: FormTableViewCell.identifier)
        configureView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        self.addSubview(formStackView)
    }
    
    private func setupConstraint() {
        formStackView.translatesAutoresizingMaskIntoConstraints = false
        formStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        formStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        formStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        formStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    
}
