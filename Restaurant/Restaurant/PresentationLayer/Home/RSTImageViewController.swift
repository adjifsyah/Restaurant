//
//  RSTImageViewController.swift
//  Restaurant
//
//  Created by Adji Firmansyah on 07/06/22.
//

import UIKit
import AVFoundation

protocol RSTImageDelegate: class, ValidateMediaDelegate {
    func passImage(url: URL)
}
class RSTImageViewController: UIViewController {
    lazy var imagePicker: UIImagePickerController = {
        var imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = ["public.image"]
        return imagePicker
    }()
    
    lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onImageViewTapped))
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
    
    lazy var imageContainer: UIView = UIView()
    var delegate: RSTImageDelegate?
    var urlUser: URL?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("is image view will appear", urlUser)
        validateUserPick()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        addSubview()
        configureView()
        setupNavBar()
        setupConstraint()
    }
    
    func configureView() {
        imageContainer.backgroundColor = .lightGray
    }
    
    func addSubview() {
        view.addSubview(imageContainer)
        imageContainer.addSubview(imageView)
    }
    
    func setupNavBar() {
        let uploadItem = UIBarButtonItem(title: "Upload", style: .done, target: self, action: #selector(uploadImage))
//        let cancelItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(deleteData))
        navigationItem.rightBarButtonItem = uploadItem
//        navigationItem.leftBarButtonItem = cancelItem
    }
    
    @objc func uploadImage() {
        guard let url = urlUser else { return }
        delegate?.passImage(url: url)
        delegate?.onChange()
        dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func onImageViewTapped() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func validateUserPick() {
        
        if urlUser?.absoluteString == nil {
            imageView.image = UIImage(systemName: "photo")
            imageView.contentMode = .scaleAspectFit
            print("TRUE")
        } else {
            imageView.contentMode = .scaleAspectFill
            imageView.sd_setImage(with: urlUser, placeholderImage: UIImage(systemName: "photo"))
        }
    }
    
    func setupConstraint() {
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        imageContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        imageContainer.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        imageView.topAnchor.constraint(equalTo: imageContainer.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor).isActive = true
//        imageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
    }
    
}

extension RSTImageViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        guard let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }
        self.urlUser = imageURL
        validateUserPick()
        do {
            DispatchQueue.main.async {
                let data = try? Data(contentsOf: imageURL)
                self.imageView.image = UIImage(data: data!)
            }
        }
        
    }
}
