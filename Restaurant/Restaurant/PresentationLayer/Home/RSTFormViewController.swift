//
//  RSTFormViewController.swift
//  Restaurant
//
//  Created by Adji Firmansyah on 04/06/22.
//

import UIKit
import CoreData
import AVFoundation

protocol ValidateMediaDelegate {
    func onChange()
}

class RSTFormViewController: UIViewController {
    lazy var nameTextField: FormTextField = {
        var nameOfResto = FormTextField()
        nameOfResto.configure(placeholder: "Name restaurant")
        nameOfResto.setHeight = 40
        nameOfResto.setMargin = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: -16)
        return nameOfResto
    }()
    
    lazy var ratingTextField: FormTextField = {
        var ratingOfResto = FormTextField()
        ratingOfResto.configure(placeholder: "Rating restaurant")
        ratingOfResto.setHeight = 40
        ratingOfResto.setMargin = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: -16)
        return ratingOfResto
    }()
    
    lazy var descriptionTextField: FormTextField = {
        var descriptionOfResto = FormTextField()
        descriptionOfResto.configure(placeholder: "Description")
        descriptionOfResto.setHeight = 40
        descriptionOfResto.setMargin = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: -16)
        return descriptionOfResto
    }()
    
    lazy var menuFavoriteTextField: FormTextField = {
        var menuFavorite = FormTextField()
        menuFavorite.configure(placeholder: "Favorite menu")
        menuFavorite.setHeight = 40
        menuFavorite.setMargin = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: -16)
        return menuFavorite
    }()
    
    lazy var imageLabelBTN: UIButton = {
        var imageLabelBTN = UIButton()
        imageLabelBTN.setTitle("Choose image", for: .normal)
        imageLabelBTN.setTitleColor(.systemBlue, for: .normal)
        imageLabelBTN.addTarget(self, action: #selector(onImageViewTapped(_:)), for: .touchUpInside)
        return imageLabelBTN
    }()
    
    lazy var addImageView: UIImageView = {
        var addImageView = UIImageView()
        addImageView.clipsToBounds = true
        addImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer (target: self, action: #selector(onImageViewTapped))
        addImageView.addGestureRecognizer(tapGesture)
        addImageView.backgroundColor = .lightGray
        return addImageView
    }()
    
    lazy var videlLabelBTN: UIButton = {
        var videlLabelBTN = UIButton()
        videlLabelBTN.setTitle("Choose video", for: .normal)
        videlLabelBTN.setTitleColor(.systemBlue, for: .normal)
        videlLabelBTN.addTarget(self, action: #selector(onVideoViewTapped(_:)), for: .touchUpInside)
        return videlLabelBTN
    }()
    
    lazy var addVideoView: UIImageView = {
        var addVideoView = UIImageView()
        addVideoView.clipsToBounds = true
        addVideoView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer (target: self, action: #selector(onVideoViewTapped))
        addVideoView.addGestureRecognizer(tapGesture)
        addVideoView.backgroundColor = .lightGray
        return addVideoView
    }()
    
    lazy var videoSV: UIStackView = {
        var imageSV = UIStackView(arrangedSubviews: [addVideoView, videlLabelBTN])
        imageSV.axis = .vertical
        imageSV.spacing = 4
        //        imageSV.backgroundColor = .lightGray
        return imageSV
    }()
    
    lazy var imageSV: UIStackView = {
        var imageSV = UIStackView(arrangedSubviews: [addImageView, imageLabelBTN])
        imageSV.axis = .vertical
        imageSV.spacing = 4
        //        imageSV.backgroundColor = .lightGray
        return imageSV
    }()
    
    
    private lazy var formStackView: UIStackView = {
        var formStackView = UIStackView(
            arrangedSubviews: [
                nameTextField,
                ratingTextField,
                descriptionTextField,
                menuFavoriteTextField
            ])
        formStackView.axis = .vertical
        formStackView.spacing = 8
        formStackView.backgroundColor = .white
        return formStackView
    }()
    
    var localStorage: RSTEntity = .shared
    var imageUrl: URL?
    var videoUrl: URL?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        validateMedia()
        validateForm()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        
        addSubview()
        delegate()
        setupNavigation()
        validateMedia()
        setupConstraint()
        
    }
    
    func delegate() {
        nameTextField.formTextField.delegate = self
        ratingTextField.formTextField.delegate = self
        descriptionTextField.formTextField.delegate = self
        menuFavoriteTextField.formTextField.delegate = self
    }
    
    func addSubview() {
        view.addSubview(formStackView)
        view.addSubview(imageSV)
        view.addSubview(videoSV)
    }
    
    func onChange() {
        validateMedia()
    }
    
    private func setupNavigation() {
        title = "Add Restaurant"
        let saveButtonView = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveAction))
        navigationItem.rightBarButtonItem = saveButtonView
    }
    
    @objc private func onImageViewTapped(_ gesture: UITapGestureRecognizer) {
        let vc = RSTImageViewController()
        vc.title = "Image"
        vc.delegate = self
        vc.urlUser = imageUrl
        vc.view.backgroundColor = .white
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
    }
    
    @objc private func onVideoViewTapped(_ gesture: UITapGestureRecognizer) {
        let vc = RSTVideoViewController()
        vc.delegate = self
        vc.urlUserPickedVideo = videoUrl
        vc.view.backgroundColor = .white
        vc.title = "Video"
        let nav = UINavigationController(rootViewController: vc)
        
        present(nav, animated: true, completion: nil)
    }
    
    @objc private func saveAction() {
        guard let nameOfRestaurant = nameTextField.formTextField.text else { return }
        guard let ratingRestaurant = Float(ratingTextField.formTextField.text ?? "0.0") else { return }
        guard let descOfRestaurant = descriptionTextField.formTextField.text else { return }
        guard let favoriteMenu = menuFavoriteTextField.formTextField.text else { return }
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let manageContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "RestaurantData", in: manageContext)
        let newRestaurant = NSManagedObject(entity: entity ?? NSEntityDescription(), insertInto: manageContext)
        let imageURL = imageUrl?.absoluteString
        let videoURL = videoUrl?.absoluteString
        newRestaurant.setValue(nameOfRestaurant, forKey: "nameOfRestaurant")
        newRestaurant.setValue(ratingRestaurant, forKey: "ratingRestaurant")
        newRestaurant.setValue(descOfRestaurant, forKey: "descOfRestaurant")
        newRestaurant.setValue(favoriteMenu, forKey: "favoriteMenu")
        newRestaurant.setValue(imageURL, forKey: "imageURL")
        newRestaurant.setValue(videoURL, forKey: "videoURL")
        
        do {
            try manageContext.save()
            navigationController?.popViewController(animated: true)
        } catch {
            print("Error Saving")
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func deleteData() {
        dismiss(animated: true, completion: nil)
    }
    
    func videoSnapshot(filePathLocal: URL) -> UIImage? {
        
        
        let asset = AVURLAsset(url: filePathLocal)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        
        let timestamp = CMTime(seconds: 1, preferredTimescale: 60)
        
        do {
            let imageRef = try generator.copyCGImage(at: timestamp, actualTime: nil)
            return UIImage(cgImage: imageRef)
        }
        catch let error as NSError
        {
            print("Image generation failed with error \(error)")
            return nil
        }
    }
    
    private func validateMedia() {
        print("VALIDATE MEDIA FORM")
        if let imageURL = imageUrl {
            addImageView.sd_setImage(with: imageURL )
            addImageView.contentMode = .scaleAspectFill
        } else if let videoURL = videoUrl {
            addVideoView.image = videoSnapshot(filePathLocal: videoURL)
            addVideoView.contentMode = .scaleAspectFill
        } else {
            addImageView.image = UIImage(systemName: "photo")
            addImageView.contentMode = .scaleAspectFit
            addVideoView.image = UIImage(systemName: "video")
            addVideoView.contentMode = .scaleAspectFit
        }
        
    }
    
    private func validateForm() {
        print("validateForm is called")
        let isNameTFEmoty = nameTextField.formTextField.text == ""
        let isRatingEmpty = ratingTextField.formTextField.text == ""
        let isDescriptionEmpty = descriptionTextField.formTextField.text == ""
        let isFaveoriteEmpty = menuFavoriteTextField.formTextField.text == ""
        
        if isNameTFEmoty || isRatingEmpty || isDescriptionEmpty || isFaveoriteEmpty {
            navigationItem.rightBarButtonItem?.isEnabled = false
            navigationItem.rightBarButtonItem?.tintColor = .gray
            print("TRUE")
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = true
            navigationItem.rightBarButtonItem?.tintColor = .systemBlue
            print("FALSE")
        }
    }
    
    private func setupConstraint() {
        formStackView.translatesAutoresizingMaskIntoConstraints = false
        imageSV.translatesAutoresizingMaskIntoConstraints = false
        videoSV.translatesAutoresizingMaskIntoConstraints = false
        
        formStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        formStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        formStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        addImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        addVideoView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        imageSV.topAnchor.constraint(equalTo: formStackView.bottomAnchor, constant: 24).isActive = true
        imageSV.leadingAnchor.constraint(equalTo: formStackView.leadingAnchor).isActive = true
        imageSV.trailingAnchor.constraint(equalTo: formStackView.trailingAnchor).isActive = true
        
        videoSV.topAnchor.constraint(equalTo: imageSV.bottomAnchor, constant: 24).isActive = true
        videoSV.leadingAnchor.constraint(equalTo: formStackView.leadingAnchor).isActive = true
        videoSV.trailingAnchor.constraint(equalTo: formStackView.trailingAnchor).isActive = true
        
    }
    
}

extension RSTFormViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print(textField.text)
        validateForm()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}

extension RSTFormViewController: RSTImageDelegate {
    func passImage(url: URL) {
        self.imageUrl = url
    }
}

extension RSTFormViewController: RSTVideoDelegate {
    
    func passVideoURL(url: URL) {
        self.videoUrl = url
    }
}

