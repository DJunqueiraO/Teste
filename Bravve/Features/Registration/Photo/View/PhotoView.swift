//
//  NomeView.swift
//  Bravve
//
//  Created by user218260 on 7/15/22.
//

import UIKit

class FotoView: UIViewController {
    
    private let bravveIcon = UIImageView()
    
    private let backButton = UIButton()
    
    private let registerButton = UIButton()
    
    private let firstWay = UIImageView(),
        secondWay = UIImageView()
    
    private lazy var progressBarStackView: UIStackView = {
        
        let buttons = createProgressBarButtons([IconsBravve.photoBlue.rawValue,
                                                IconsBravve.noteGray.rawValue,
                                                IconsBravve.hobbiesGray.rawValue,
                                                IconsBravve.activitiesGray.rawValue])
        let stackView = UIStackView(arrangedSubviews: buttons)
        
        return stackView
    }()
    
    private let infoLabel: UILabel = {
        
        let infoLabel = UILabel()
        infoLabel.setToDefault(text: "Quer adicionar uma foto ao seu perfil, agora? Esse passo é opcional!")
        
        return infoLabel
    }()
    
    private let tutorialLabel: UILabel = {
        
        let infoLabel = UILabel()
        infoLabel.setToDefault(text: "Recomendado: 512x512\nMáximo: 2MB")
        
        return infoLabel
    }()
    
    private let imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.layer.masksToBounds = false
        imageView.image = UIImage(named: ImagesBravve.photo.rawValue)
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let editButton: UIButton = {
        
        let editButton = UIButton()
        editButton.setImage(UIImage(named: IconsBravve.photoBlue.rawValue),
                            for: .normal)
        
        return editButton
    }()
    
    let imagePicker = UIImagePickerController()
    
    let networkManager = NetworkManager()
    
    
    override func viewDidLoad() {
        
        setupView()
        setupDefaults()
        setupConstraints()
        
        registerButton.addTarget(self, action: #selector(actionRegisterButton), for: .touchUpInside)
        
        editButton.addTarget(self, action: #selector(showGallery), for: .touchUpInside)
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary;
        imagePicker.allowsEditing = true
        
        super.viewDidLoad()
    }
    
    private func setupView() {
        
        view.addSubviews([firstWay, secondWay, bravveIcon, backButton, progressBarStackView, infoLabel, registerButton, imageView, editButton, tutorialLabel])
        
        view.setToDefaultBackgroundColor()
    }
    
    private func setupDefaults() {
        
        firstWay.setWayToDefault(.wayConfirm_1)
        secondWay.setWayToDefault(.wayCell)
        bravveIcon.setLogoToDefault()
        backButton.setToBackButtonDefault(.backPink) {_ in
            self.dismiss(animated: true)
        }
        registerButton.setToBottomButtonKeyboardDefault(backgroundColor: .buttonPink)
    }
    
    private func setupConstraints() {
        
        progressBarStackView.constraintOutsideTo(.top, bravveIcon,
                                                 CGFloat(50).generateSizeForScreen)
        progressBarStackView.constraintInsideTo(.centerX, view.safeAreaLayoutGuide)
        
        infoLabel.constraintOutsideTo(.top, progressBarStackView,
                                      CGFloat(50).generateSizeForScreen)
        infoLabel.constraintInsideTo(.leading, view.safeAreaLayoutGuide,
                                     CGFloat(40).generateSizeForScreen)
        infoLabel.constraintInsideTo(.trailing, view.safeAreaLayoutGuide,
                                     CGFloat(40).generateSizeForScreen)
        
        imageView.constraintInsideTo(.centerX, view.safeAreaLayoutGuide)
        imageView.constraintInsideTo(.centerY, view.safeAreaLayoutGuide,
                                     CGFloat(30).generateSizeForScreen)
        imageView.sizeAnchorInSuperview(view.frame.size.height/5)
        imageView.layer.cornerRadius = view.frame.size.height/10
        
        tutorialLabel.constraintOutsideTo(.top, imageView, 25)
        tutorialLabel.constraintOutsideTo(.centerX, view)
        
        editButton.sizeAnchorInSuperview(CGFloat(32).generateSizeForScreen)
        editButton.constraintInsideTo(.centerX, imageView, view.frame.size.height/15)
        editButton.constraintInsideTo(.centerY, imageView, view.frame.size.height/15)
    }
    
    @objc func actionRegisterButton() {
        let vc = ProfessionView()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
   
}

extension FotoView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func showGallery() {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            DispatchQueue.main.async {
                self.imageView.image = pickedImage
            }
            
            guard let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }
            
            networkManager.uploadPictureWithResponse(uuid: "466c669a-a1d4-4bcd-9808-1e49afb1b806",endpoint: .usersPictures, picture_url: imageURL) { (updatedPicture: UploadPicture?) in
                print(updatedPicture)
            }
            
            dismiss(animated: true)
            
        }
    }
}
