//
//  GridView.swift
//  Instagrid
//
//  Created by Elie Arquier on 22/10/2019.
//  Copyright © 2019 Elie Arquier. All rights reserved.
//

import UIKit

class GridView: UIView {
    @IBOutlet var topLeftButton: UIButton!
    @IBOutlet var topRightButton: UIButton!
    @IBOutlet var bottomLeftButton: UIButton!
    @IBOutlet var bottomRightButton: UIButton!

    enum Grid {
        case first, center, last
    }

    var grid: Grid = .center {
        didSet {
            switch grid {
            case .first:
                first()
            case .center:
                center()
            case .last:
                last()
            }
        }
    }
}

// MARK: Grid dipsosition choice
extension GridView {
    private func first() {
        topLeftButton.isHidden = false
        topRightButton.isHidden = true
        bottomLeftButton.isHidden = false
        bottomRightButton.isHidden = false
    }

    private func center() {
        topLeftButton.isHidden = false
        topRightButton.isHidden = false
        bottomLeftButton.isHidden = false
        bottomRightButton.isHidden = true
    }

    private func last() {
        topLeftButton.isHidden = false
        topRightButton.isHidden = false
        bottomLeftButton.isHidden = false
        bottomRightButton.isHidden = false
    }
}

//MARK: Reload grid after share success
extension GridView {
    // reload the grid after saving image
    func reloadGrid() {
        let selectedImage = UIImage(named: "Plus")
        topLeftButton.setImage(selectedImage, for: .normal)
        topRightButton.setImage(selectedImage, for: .normal)
        bottomLeftButton.setImage(selectedImage, for: .normal)
        bottomRightButton.setImage(selectedImage, for: .normal)
    }
}

// MARK: Transform grid as image
extension GridView {
    func transformAsImage() -> UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
    }
}

// MARK: animation for changing disposition grid
extension GridView {
    func shake() {
        let shake = CABasicAnimation(keyPath: "position")

        shake.duration = 0.1
        shake.repeatCount = 1
        shake.autoreverses = true

        let fromPoint = CGPoint(x: center.x-10, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)

        let toPoint = CGPoint(x: center.x+10, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)

        shake.fromValue = fromValue
        shake.toValue = toValue

        layer.add(shake, forKey: nil)
    }
}
