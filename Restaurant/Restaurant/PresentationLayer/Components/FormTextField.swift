//
//  FormTextField.swift
//  Restaurant
//
//  Created by Adji Firmansyah on 04/06/22.
//

import UIKit

class FormTextField: UIView {
    lazy var formTextField: UITextField = UITextField()
    
    lazy var divider: UIView = {
        var divider = UIView()
        divider.backgroundColor = .black
        divider.layer.opacity = 0.3
        divider.heightAnchor.constraint(equalToConstant: 0.08).isActive = true
        return divider
    }()
    
    private var topConstraint: NSLayoutConstraint?
    private var leadingConstraint: NSLayoutConstraint?
    private var bottomConstraint: NSLayoutConstraint?
    private var trailingConstraint: NSLayoutConstraint?
    
    var setMargin: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) {
        didSet { updateMarginConstraint() }
    }
    
    var setHeight: CGFloat? {
        didSet {
            updateHeightConstraint()
        }
    }
    
    private var heightConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubview() {
        self.addSubview(formTextField)
        self.addSubview(divider)
    }
    
    func configure(placeholder: String, backgroundColor: UIColor? = nil) {
        formTextField.placeholder = placeholder
        formTextField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        formTextField.backgroundColor = backgroundColor
    }
    
    private func setupConstraint() {
        formTextField.translatesAutoresizingMaskIntoConstraints = false
        divider.translatesAutoresizingMaskIntoConstraints = false
        
        self.topConstraint = formTextField.topAnchor.constraint(
            equalTo: self.topAnchor,
            constant: setMargin.left
        )
        self.topConstraint?.isActive = true
        self.leadingConstraint = formTextField.leadingAnchor.constraint(
            equalTo: self.leadingAnchor,
            constant: setMargin.left)
        self.leadingConstraint?.isActive = true
        self.bottomConstraint = formTextField.bottomAnchor.constraint(
            equalTo: self.bottomAnchor,
            constant: setMargin.left)
        self.bottomConstraint?.isActive = true
        self.trailingConstraint = formTextField.trailingAnchor.constraint(
            equalTo: self.trailingAnchor,
            constant: setMargin.left)
        self.trailingConstraint?.isActive = true
        
        divider.topAnchor.constraint(equalTo: self.formTextField.bottomAnchor).isActive = true
        divider.leadingAnchor.constraint(equalTo: self.formTextField.leadingAnchor).isActive = true
        divider.trailingAnchor.constraint(equalTo: self.formTextField.trailingAnchor).isActive = true
        
    }
    
    private func updateMarginConstraint() {
        self.topConstraint?.constant = setMargin.top
        self.leadingConstraint?.constant = setMargin.left
        self.bottomConstraint?.constant = setMargin.bottom
        self.trailingConstraint?.constant = setMargin.right
    }
    
    private func updateHeightConstraint() {
        self.heightConstraint = formTextField.heightAnchor.constraint(equalToConstant: setHeight ?? 0)
        self.heightConstraint?.isActive = true
    }
    
    
}
