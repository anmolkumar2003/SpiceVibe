//  FavoritesViewController.swift
//  Spice Vibe
//  Created by caglobal on 03/03/25.

import UIKit
import Lottie

class FavoritesViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        LoaderManager.shared.showWorkInProgressLoader(on: self.view)
    }
}
