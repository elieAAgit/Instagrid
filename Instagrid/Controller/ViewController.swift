//
//  ViewController.swift
//  Instagrid
//
//  Created by Elie Arquier on 15/10/2019.
//  Copyright © 2019 Elie Arquier. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gridView: GridView!
    @IBOutlet var bottomButtons: [UIButton]!
    @IBOutlet var selectedBottomButtons: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func whenFirstButtonIsTapped(_ sender: UIButton) {
        selectFirstDisposition()
    }
    
    @IBAction func whenCenterButtonIsTapped(_ sender: UIButton) {
        selectCenterDisposition()
    }
    
    @IBAction func whenLastButtonIsTapped(_ sender: UIButton) {
        selectLastDisposition()
    }
    
    func selectFirstDisposition() {
        gridView.grid = .first
        untapButtons()
        selectedBottomButtons[0].isHidden = false
    }
    
    func selectCenterDisposition() {
        gridView.grid = .center
        untapButtons()
        selectedBottomButtons[1].isHidden = false
    }
    
    func selectLastDisposition() {
        gridView.grid = .last
        untapButtons()
        selectedBottomButtons[2].isHidden = false
    }
    
    func untapButtons() {
        for index in 0 ... selectedBottomButtons.count - 1 {
            selectedBottomButtons[index].isHidden = true
        }
    }
}

