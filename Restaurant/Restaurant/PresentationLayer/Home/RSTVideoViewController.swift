//
//  RSTVideoViewController.swift
//  Restaurant
//
//  Created by Adji Firmansyah on 06/06/22.
//

import UIKit
import AVFoundation

protocol RSTVideoDelegate: class, ValidateMediaDelegate {
    func passVideoURL(url: URL)
}

class RSTVideoViewController: UIViewController {
    lazy var videoPicker: UIImagePickerController = UIImagePickerController()
    lazy var videoIconDefault: UIImageView = {
        var videoIconDefault = UIImageView()
        videoIconDefault.contentMode = .scaleAspectFill
        videoIconDefault.clipsToBounds = true
        videoIconDefault.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onVideoViewTapped))
        videoIconDefault.addGestureRecognizer(tapGesture)
        return videoIconDefault
    }()
    lazy var videoContainer: VideoContainerView = VideoContainerView()
    
    lazy var playButton: UIButton = {
        var playButton = UIButton()
        playButton.setTitle("Play", for: .normal)
        playButton.setTitleColor(.systemBlue, for: .normal)
        playButton.addTarget(self, action: #selector(play), for: .touchUpInside)
        return playButton
    }()
    
    var urlUserPickedVideo: URL?
    var avPlayer: AVPlayer?
    var avPlayerLayer: AVPlayerLayer?
    weak var delegate: RSTVideoDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        validateVideo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(videoContainer)
        videoContainer.addSubview(videoIconDefault)
        view.addSubview(playButton)
        videoPicker.delegate = self
        
        setupNavBar()
        setupConstraint()
    }
    
    @objc func play() {
        print("Play")
        avPlayer?.play()
    }
    
    func setupNavBar() {
        let uploadItem = UIBarButtonItem(title: "Upload", style: .done, target: self, action: #selector(uploadVideo))
//        let cancelItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(deleteData))
        navigationItem.rightBarButtonItem = uploadItem
//        navigationItem.leftBarButtonItem = cancelItem
    }
    
    @objc func uploadVideo() {
        guard let url = urlUserPickedVideo else { return }
        print("UPLOAD", url)
        delegate?.passVideoURL(url: url)
        delegate?.onChange()
        dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func onVideoViewTapped() {
        videoPicker.sourceType = .photoLibrary
        videoPicker.mediaTypes = ["public.movie"]
        videoPicker.videoQuality = .typeMedium
        videoPicker.videoExportPreset = AVAssetExportPreset960x540
        present(videoPicker, animated: true, completion: nil)
    }
    
    private func validateVideo() {
        if urlUserPickedVideo?.absoluteString != nil {
            videoIconDefault.contentMode = .scaleAspectFill
            videoIconDefault.isHidden = true
            
        } else {
            videoIconDefault.image = UIImage(systemName: "video")
            videoIconDefault.contentMode = .scaleAspectFit
            videoIconDefault.isHidden = false
        }
        
    }
    
    func setupConstraint() {
        videoContainer.translatesAutoresizingMaskIntoConstraints    = false
        videoIconDefault.translatesAutoresizingMaskIntoConstraints  = false
        playButton.translatesAutoresizingMaskIntoConstraints        = false
        //        let ratio: CGFloat = CGFloat(16/9)
        videoContainer.heightAnchor.constraint(equalToConstant: 180).isActive                       = true
        videoContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive   = true
        videoContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive               = true
        videoContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive             = true
        
        videoIconDefault.topAnchor.constraint(equalTo: videoContainer.topAnchor).isActive           = true
        videoIconDefault.leadingAnchor.constraint(equalTo: videoContainer.leadingAnchor).isActive   = true
        videoIconDefault.trailingAnchor.constraint(equalTo: videoContainer.trailingAnchor).isActive = true
        videoIconDefault.bottomAnchor.constraint(equalTo: videoContainer.bottomAnchor).isActive     = true
//        videoIconDefault.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        playButton.topAnchor.constraint(equalTo: videoContainer.bottomAnchor, constant: 24).isActive = true
        playButton.centerXAnchor.constraint(equalTo: videoContainer.centerXAnchor).isActive          = true
    }
}

extension RSTVideoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        let userPickedVideo =  info[UIImagePickerController.InfoKey.mediaURL] as? URL
        let userVideoData   =  info[UIImagePickerController.InfoKey.mediaURL] as? Data
        print(userVideoData)
        validateVideo()
        self.urlUserPickedVideo = userPickedVideo
        
        avPlayer = AVPlayer(url: urlUserPickedVideo!)
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer?.frame = videoContainer.bounds
        
        avPlayerLayer?.videoGravity = .resizeAspectFill
        videoContainer.layer.addSublayer(avPlayerLayer ?? AVPlayerLayer())
        videoContainer.playerLayer = avPlayerLayer
        videoContainer.backgroundColor = .lightGray
        avPlayer?.play()
        
    }
}

class VideoContainerView: UIView {
    var playerLayer: CALayer?
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        playerLayer?.frame = self.bounds
    }
}

