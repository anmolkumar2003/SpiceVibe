//  SignUpViewController.swift
//  Spice Vibe
//  Created by caglobal on 21/02/25.

import UIKit
import RAMAnimatedTabBarController

class SignUpViewController: UIViewController {
    
    @IBOutlet var signUpVcMainView: UIView!
    @IBOutlet weak var confirmPassTfView: UIView!
    @IBOutlet weak var backButtonView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var confirmPasswordView: UIView!
    @IBOutlet weak var passTfView: UIView!
    @IBOutlet weak var emailTfView: UIView!
    @IBOutlet weak var fullNameTfView: UIView!
    @IBOutlet weak var fullNameView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewUI()
        
    }
    
    //MARK: IBActions
    
    @IBAction func signUpBtn(_ sender: Any) {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
              let window = sceneDelegate.window,
              let tabBarVC = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController else {
            print("Failed to switch to MainTabBarController")
            return
        }
        
        window.rootViewController = tabBarVC
        window.makeKeyAndVisible()
        
        UserDefaults.standard.setValue(true, forKey: "signUPSuccessfully")
    }
    
    @IBAction func signInBtn(_ sender: Any) {
        let loginVc = SpiceVibeStoryBoards.viewController(from: .login, ofType: LoginViewController.self)
        self.navigationController?.pushViewController(loginVc, animated: true)
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        let loginVc = SpiceVibeStoryBoards.viewController(from: .DetailedRecipe, ofType: DetailedRecipeViewController.self)
        self.navigationController?.pushViewController(loginVc, animated: true)
        
    }
    
    func setViewUI(){
        signUpButton.cornerRadius = 10
        backButtonView.layer.cornerRadius = backButtonView.frame.width / 2
        backButtonView.layer.shadowColor = UIColor.black.cgColor
        backButtonView.layer.shadowOpacity = 0.2
        backButtonView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backButtonView.layer.shadowRadius = 10
        backButtonView.layer.masksToBounds = false
        backButtonView.layer.shadowPath = UIBezierPath(ovalIn: backButtonView.bounds).cgPath
        confirmPassTfView.cornerRadius = 10
        confirmPassTfView.borderColor = .lightGray
        confirmPassTfView.borderWidth = 1
        passTfView.cornerRadius = 10
        passTfView.borderColor = .lightGray
        passTfView.borderWidth = 1
        emailTfView.cornerRadius = 10
        emailTfView.borderColor = .lightGray
        emailTfView.borderWidth = 1
        fullNameTfView.cornerRadius = 10
        fullNameTfView.borderColor = .lightGray
        fullNameTfView.borderWidth = 1
    }
}
