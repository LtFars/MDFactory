//
//  ProfilViewController.swift
//  MDFactory
//
//  Created by Andrei Maskal on 01/09/2022.
//

import UIKit

class ProfileViewController: BottomSheetController {
            
    override func viewDidLoad() {
        super.viewDidLoad()
        view = ProfileView()
        
        view.backgroundColor = .white

    }
}

