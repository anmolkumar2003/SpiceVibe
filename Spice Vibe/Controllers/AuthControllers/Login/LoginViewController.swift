//  LoginViewController.swift
//  Spice Vibe
//  Created by caglobal on 21/02/25.

import UIKit
import GoogleSignIn

var isComeFromLogin = false
class LoginViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
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
        activityIndicator.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateLoginUi()
    }
    
    //MARK: - IBActions
    
    @IBAction func googleLoginBtn(_ sender: UIButton) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in

            guard error == nil else { return }

          // If sign in succeeded, display the app's main content View.
            guard let signInResult = signInResult else { return }
            let user = signInResult.user
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                self.goToHomeScreen()
                self.activityIndicator.isHidden = true
            })
            
            googleUserName = user.profile?.name ?? ""
            googleUserPicUrl = user.profile?.imageURL(withDimension: 320)?.absoluteString ?? ""
            googleUserEmail = user.profile?.email ?? ""
        }
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signupBtn(_ sender: Any) {
        isComeFromLogin = true
        let signUpVc = SpiceVibeStoryBoards.viewController(from: .signUp, ofType: SignUpViewController.self)
        self.navigationController?.pushViewController(signUpVc, animated: true)
    }
    
    @IBAction func signInBtnAction(_ sender: Any) {
        let homeVc = SpiceVibeStoryBoards.viewController(from: .main, ofType: HomeViewController.self)
        self.navigationController?.pushViewController(homeVc, animated: true)
    }
    
    //MARK: - Functions
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
    
    func goToHomeScreen() {
        let homeVc = SpiceVibeStoryBoards.viewController(from: .main, ofType: HomeViewController.self)
        navigationController?.pushViewController(homeVc, animated: true)
    }
}
