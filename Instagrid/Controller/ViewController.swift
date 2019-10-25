//
//  ViewController.swift
//  Instagrid
//
//  Created by Elie Arquier on 15/10/2019.
//  Copyright © 2019 Elie Arquier. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var buttonTapped: UIButton?

    @IBOutlet weak var gridView: GridView!
    @IBOutlet var bottomButtons: [UIButton]!
    @IBOutlet var selectedBottomButtons: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gridView.grid = .center
    }
}

extension ViewController {
    @IBAction func whenBottomButtonIsTapped(_ sender: UIButton) {
            untapButtons()

        switch sender {
        case bottomButtons[0]:
            gridView.grid = .first
            selectedBottomButtons[0].isHidden = false
        case bottomButtons[1]:
            gridView.grid = .center
            selectedBottomButtons[1].isHidden = false
        case bottomButtons[2]:
            gridView.grid = .last
            selectedBottomButtons[2].isHidden = false
        default:
            break
        }
    }

    private func untapButtons() {
        for index in 0 ... selectedBottomButtons.count - 1 {
            selectedBottomButtons[index].isHidden = true
        }
    }
}

// MARK : Choose Image
extension ViewController {
    @IBAction func whenButtonChooseImageIsTapped(_ sender: UIButton) {
        buttonTapped = sender

        showImagePickerController()
    }
}

// MARK : UIImagePickerController
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private func showImagePickerController() {

        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            guard let buttonChoice = buttonTapped else {
                return
            }
            buttonChoice.setImage(selectedImage, for: .normal)
        }

        dismiss(animated: true, completion: nil)
    }
}
