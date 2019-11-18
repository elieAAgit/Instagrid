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

    @IBOutlet weak var instagridLabel: UILabel!
    @IBOutlet weak var swipeUp: UIView!
    @IBOutlet weak var swipeLeft: UIView!
    @IBOutlet weak var gridView: GridView!
    @IBOutlet var bottomButtons: [UIButton]!
    @IBOutlet var selectedBottomButtons: [UIImageView]!

    override func viewDidLoad() {
        super.viewDidLoad()

        loadGrid()

        swipeGesture()
    }
}

// MARK: Choosing grid disposition
extension ViewController {
    @IBAction func whenBottomButtonIsTapped(_ sender: UIButton) {
        var selectedIndex = Int()

        untapButtons()

        switch sender {
        case bottomButtons[0]:
            gridView.grid = .first
            selectedIndex = 0
        case bottomButtons[1]:
            gridView.grid = .center
            selectedIndex = 1
        case bottomButtons[2]:
            gridView.grid = .last
            selectedIndex = 2
        default:
            break
        }

        animatedBottomButton(gesture: sender, selectedIndex: selectedIndex)

        gridView.shake()
    }

    private func untapButtons() {
        for index in 0 ... selectedBottomButtons.count - 1 {
        selectedBottomButtons[index].isHidden = true
        }
    }
}

// MARK: Choose and show image for grid button's
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBAction func whenButtonChooseImageIsTapped(_ sender: UIButton) {
        buttonTapped = sender

        animatedGridButton(gesture: sender)

        showImagePickerController()
    }
    
    // UIImagePickerController
    private func showImagePickerController() {

        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:
        [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            guard let buttonChoice = buttonTapped else {
                return
            }
            buttonChoice.setImage(selectedImage, for: .normal)
        }

        dismiss(animated: true, completion: nil)
    }
}

// MARK: SwipeGestureReconizer
extension ViewController {
    private func swipeGesture() {
        let swipeUpGestureReconizer = UISwipeGestureRecognizer(target: self, action:
            #selector (whenUpGestureIsMade(_:)))
        let swipeLeftGestureReconizer = UISwipeGestureRecognizer(target: self, action:
            #selector (whenLeftGestureIsMade(_:)))

        swipeUpGestureReconizer.direction = .up
        swipeLeftGestureReconizer.direction = .left

        swipeUp.addGestureRecognizer(swipeUpGestureReconizer)
        swipeLeft.addGestureRecognizer(swipeLeftGestureReconizer)
    }

    @objc private func whenUpGestureIsMade(_ gesture: UISwipeGestureRecognizer) {
        let screenHeight = UIScreen.main.bounds.height
        gesture.direction = .up

        UIView.animate(withDuration: 1) {
                self.gridView.transform = CGAffineTransform(translationX: 0, y: -screenHeight)
        }
        UIViewActivityController()
    }

    @objc private func whenLeftGestureIsMade(_ gesture: UISwipeGestureRecognizer) {
        let screenWidth = UIScreen.main.bounds.width
        gesture.direction = .left

        UIView.animate(withDuration: 1) {
                self.gridView.transform = CGAffineTransform(translationX: -screenWidth, y: 0)
        }
        UIViewActivityController()
    }
}

// MARK: UIViewActivityController
extension ViewController {
    private func UIViewActivityController() {
        let gridImage = gridView.transformAsImage()
        let item = [gridImage]
        let activityController = UIActivityViewController(activityItems: item as [Any], applicationActivities: nil)

        present(activityController, animated: true)

        activityController.completionWithItemsHandler = { (activityType, completed: Bool,
            returnedItems: [Any]?, error: Error?) in
            if completed {
                self.gridView.reloadGrid()
                self.presentAlert()
           }

            UIView.animate(withDuration: 1) {
                self.gridView.transform = .identity
            }
        }
    }
}

// MARK: Alerte share success
extension ViewController {
    private func presentAlert() {
        let alert = UIAlertController(title: "Share success!" , message: "You have shared your image with success.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: animation
extension ViewController {
    private func loadGrid() {
        gridView.grid = .center
        gridView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)

        UIView.animate(withDuration: 0.5) {
        self.gridView.transform = .identity
        }
    }

    private func animatedGridButton(gesture: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5,
                       options: .curveEaseIn, animations: {
            gesture.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }) { (_) in
            gesture.transform = .identity
        }
    }

    private func animatedBottomButton(gesture: UIButton, selectedIndex: Int) {
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.85,
                       initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            gesture.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }) { (_) in
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.85,
                           initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
                gesture.transform = CGAffineTransform(scaleX: 1, y: 1)
            }) { (_) in
                self.selectedBottomButtons[selectedIndex].isHidden = false
            }
        }
    }
}
