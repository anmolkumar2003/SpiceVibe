//  SampleMenuViewController.swift
//  Spice Vibe
//  Created by anmol on 03/03/25.

import UIKit

class SampleMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
