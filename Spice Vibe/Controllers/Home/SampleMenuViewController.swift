//  SampleMenuViewController.swift
//  Spice Vibe
//  Created by anmol on 03/03/25.

import UIKit
import GoogleSignIn

class SampleMenuViewController: UIViewController {

    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblName: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        lblEmail.text = googleUserEmail
        lblName.text = googleUserName
        let url = URL(string: googleUserPicUrl)
        userImg.sd_setImage(with: url)
    }
    
    @IBAction func logOutBtn(_ sender: UIButton) {
        GIDSignIn.sharedInstance.signOut()
        googleUserEmail = ""
        googleUserName = ""
        googleUserPicUrl = ""
        let loginVc = SpiceVibeStoryBoards.viewController(from: .login, ofType: LoginViewController.self)
        navigationController?.pushViewController(loginVc, animated: true)
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
