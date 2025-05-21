//  SignUpViewController.swift
//  Spice Vibe
//  Created by anmol on 21/02/25.

import UIKit
import RAMAnimatedTabBarController
import GoogleSignIn

var googleUserName = String()
var googleUserPicUrl = String()
var googleUserEmail = String()

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var passwordVisibilityToggleBtn: UIButton!
    @IBOutlet weak var confirmPasswordView: UIView!
    @IBOutlet weak var signInBtnOutlet: UIButton!
    @IBOutlet var signUpVcMainView: UIView!
    @IBOutlet weak var confirmPassTfView: UIView!
    @IBOutlet weak var backButtonView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var confirmPasswordVisibilityToggle: UIButton!
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
    
    let errorLabel = UILabel()
    var confirmPassToggle = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewUI()
        activityIndicator.isHidden = true
    }
    
    //MARK: IBActions
    
    @IBAction func signUpBtn(_ sender: Any) {
        
        guard let email = emailTextField.text,
                let password = passwordTextField.text,
                let confirmPassword = confirmPasswordTextField.text else {
              errorLabel.text = "Please fill all fields."
              return
          }
          
          if !isValidEmail(email) {
              errorLabel.text = "Invalid email address."
          } else if !isValidPassword(password) {
              errorLabel.text = "Password must be at least 6 characters."
          } else if !doPasswordsMatch(password, confirmPassword) {
              errorLabel.text = "Passwords do not match."
          } else {
              errorLabel.text = ""
        
          }
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
    
    @IBAction func googleSignInButton(_ sender: UIButton) {
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

    @IBAction func signInBtn(_ sender: Any) {
        let loginVc = SpiceVibeStoryBoards.viewController(from: .login, ofType: LoginViewController.self)
        self.navigationController?.pushViewController(loginVc, animated: true)
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        let loginVc = SpiceVibeStoryBoards.viewController(from: .DetailedRecipe, ofType: DetailedRecipeViewController.self)
        self.navigationController?.pushViewController(loginVc, animated: true)
    }
    
    @IBAction func passwordToggleBtnAction(_ sender: UIButton) {
        confirmPassToggle.toggle()
       if confirmPassToggle{
           passwordVisibilityToggleBtn.setImage(UIImage(named: "eye"), for: .normal)
       } else{
           passwordVisibilityToggleBtn.setImage(UIImage(named: "eye-slash"), for: .normal)
       }
    }
    
    @IBAction func confrmPassToggleBtnAction(_ sender: UIButton) {
         confirmPassToggle.toggle()
        if confirmPassToggle{
            confirmPasswordVisibilityToggle.setImage(UIImage(named: "eye"), for: .normal)
        } else{
            confirmPasswordVisibilityToggle.setImage(UIImage(named: "eye-slash"), for: .normal)
        }
    }
    
    func goToHomeScreen() {
        let homeVc = SpiceVibeStoryBoards.viewController(from: .main, ofType: HomeViewController.self)
        navigationController?.pushViewController(homeVc, animated: true)
    }
    
    func setViewUI(){
        
        let labelWidth: CGFloat = 200
        let labelHeight: CGFloat = 30
        let x = signUpVcMainView.bounds.midX - (labelWidth / 2)
        let y = signUpVcMainView.bounds.midY - (labelHeight / 2)

        errorLabel.frame = CGRect(x: x, y: y, width: labelWidth, height: labelHeight)

        view.addSubview(errorLabel)
        view.bringSubviewToFront(errorLabel)
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
        signInBtnOutlet.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 14)
        signUpButton.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 14)
    }
}
