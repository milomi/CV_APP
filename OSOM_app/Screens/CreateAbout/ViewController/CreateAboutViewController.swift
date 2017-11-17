//
//  CreateAboutViewController.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 04.11.2017.
//

import Foundation
import UIKit
import SwiftValidator

fileprivate struct Constants {
    struct ActionSheet {
        static let title = "settings.actionSheet.title"
        static let message = "settings.actionSheet.message"
        static let cancel = "settings.actionSheet.cancel"
        static let library = "settings.actionSheet.library"
        static let camera = "settings.actionSheet.camera"
        static let delete = "settings.actionSheet.delete"
    }
    
    struct Alert {
        static let logoutMessage = "settings.alert.logoutMessage"
        static let deleteAccMessage = "settings.alert.deleteAccMessage"
        static let accountDeletedMessage = "settings.alert.accountDeleted"
    }
    
    static let maxImageSize = CGSize(width: 200, height: 320)
    
}

fileprivate extension Selector {
    static let onPhoto = #selector(CreateAboutViewController.onPhoto)
}

final class CreateAboutViewController: UIViewController {
    
    fileprivate let mainView: CreateAboutView
    fileprivate var navigator: NavigationController?
    fileprivate let validator = Validator()

    
    init(view: CreateAboutView) {
        mainView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupView()
        setupNavigation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mainView.fadeIn()
    }
    
    @objc func onPhoto() {
        showAddPhotoAlert()
    }
    
    fileprivate func setupView() {
        view = mainView
        mainView.setupView()
        mainView.photoButton.addTarget(self, action: .onPhoto, for: .touchUpInside)
        registerValidatableFields()
    }
}

extension CreateAboutViewController: NavigationControllerDelegate {
    
    fileprivate func setupNavigation() {
        navigator = NavigationController(navigationView: mainView.navigation, navigationController: navigationController)
        navigator?.delegate = self
    }
    
    func rightAction() {
        validator.validate(self)
    }
    
    func backAction() {
        self.navigationController?.popViewController(animated: false)
    }
}


extension CreateAboutViewController {
    
fileprivate func showAddPhotoAlert() {
    let imagePickerController = UIImagePickerController()
    imagePickerController.allowsEditing = false
    imagePickerController.delegate = self
    let title = Constants.ActionSheet.title.localized()
    let message = Constants.ActionSheet.message.localized()
    let acSheet: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    let cancelAction: UIAlertAction = UIAlertAction(title: Constants.ActionSheet.cancel.localized(), style: .cancel) { _ -> Void in }
    
    acSheet.addAction(cancelAction)
    let cameraAction: UIAlertAction = UIAlertAction(title: Constants.ActionSheet.camera.localized(), style: .default) { _ -> Void in
        imagePickerController.sourceType = .camera
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    acSheet.addAction(cameraAction)
    let libraryAction: UIAlertAction = UIAlertAction(title: Constants.ActionSheet.library.localized(), style: .default) { _ -> Void in
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    acSheet.addAction(libraryAction)
    self.present(acSheet, animated: true, completion: nil)
    
    }

}

extension CreateAboutViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        
        let resizedImage = chosenImage.resize(Constants.maxImageSize)
        mainView.photoButton.setImage(resizedImage, for: .normal)
        //viewModel.updateUserPhoto(image: resizedImage)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

extension CreateAboutViewController: ValidationDelegate {
    func validationSuccessful() {
        let vc = ViewControllerContainer.shared.getAddEducation()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        for (field, error) in errors {
            if let field = field as? UITextView {
                field.shake()
            }
        }
    }
    
    fileprivate func registerValidatableFields() {
        //validator.registerField(mainView.personalStatement.textField as! ValidatableField, rules: [RequiredRule()])
    }
}
