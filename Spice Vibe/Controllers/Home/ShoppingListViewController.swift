//  ShoppingListViewController.swift
//  Spice Vibe
//  Created by caglobal on 03/03/25.

import UIKit

class ShoppingListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        LoaderManager.shared.showNooddlesLoader(on: self.view)
    }
}
