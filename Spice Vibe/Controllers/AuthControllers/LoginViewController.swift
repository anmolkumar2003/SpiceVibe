//  LoginViewController.swift
//  Spice Vibe
//  Created by caglobal on 21/02/25.

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var backBtnView: UIView!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var forgotPasswordLbl: UILabel!
    @IBOutlet weak var passwordTfView: UIView!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var emailTfView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateLoginUi()
    }
    
    //MARK: - IBActions
    
    //    @IBAction func encryptionBtn(_ sender: Any) {
    //    }
    
    @IBAction func backBtnAction(_ sender: Any) {
    }
    
    @IBAction func signupBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func signInBtnAction(_ sender: Any) {
        let homeVc = SpiceVibeStoryBoards.viewController(from: .main, ofType: HomeViewController.self)
        self.navigationController?.pushViewController(homeVc, animated: true)
    }
    
    //    @IBAction func forgotPasswordBtn(_ sender: Any) {
    //        let forgotPassVc = SpiceVibeStoryBoards.viewController(from: .forgotPassword, ofType: ForgotPasswordViewController.self)
    //        self.navigationController?.pushViewController(forgotPassVc, animated: true)
    //    }
    func updateLoginUi(){
        backBtnView.cornerRadius = backBtnView.frame.width / 2
        backBtnView.layer.shadowColor = UIColor.black.cgColor
        backBtnView.layer.shadowOpacity = 0.2
        backBtnView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backBtnView.layer.shadowRadius = 10
        backBtnView.layer.masksToBounds = false
        backBtnView.layer.shadowPath = UIBezierPath(ovalIn: backBtnView.bounds).cgPath
        signInBtn.titleLabel?.font = .boldSystemFont(ofSize: 15)
        passwordTfView.cornerRadius = 10
        passwordTfView.borderColor = .lightGray
        passwordTfView.borderWidth = 1
        emailTfView.cornerRadius = 10
        emailTfView.borderColor = .lightGray
        emailTfView.borderWidth = 1
        signInBtn.cornerRadius = 10
    }
}
