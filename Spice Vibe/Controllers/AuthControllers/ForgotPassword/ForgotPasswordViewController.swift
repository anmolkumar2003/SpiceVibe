//  ForgotPasswordViewController.swift
//  Spice Vibe
//  Created by caglobal on 21/02/25.

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var forgotPassEmailLbl: UILabel!
    @IBOutlet weak var forgotPassEmailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func sendButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
