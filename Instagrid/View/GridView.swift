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

extension GridView {
    func first() {
        topLeftButton.isHidden = false
        topRightButton.isHidden = true
        bottomLeftButton.isHidden = false
        bottomRightButton.isHidden = false
    }
    
    func center() {
        topLeftButton.isHidden = false
        topRightButton.isHidden = false
        bottomLeftButton.isHidden = false
        bottomRightButton.isHidden = true
    }
    
    func last() {
        topLeftButton.isHidden = false
        topRightButton.isHidden = false
        bottomLeftButton.isHidden = false
        bottomRightButton.isHidden = false
    }
}
