//  StoryBoardManager.swift
//  Spice Vibe
//  Created by caglobal on 21/02/25.

import Foundation
import UIKit

enum SpiceVibeStoryBoards: String {
    case main = "Main"
    case signUp = "SignUpStoryBoard"
    case login = "LoginStoryBoard"
    case forgotPassword = "ForgotPassword"
    case DetailedRecipe = "DetailedRecipe"

    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
    
    static func viewController<T: UIViewController>(from storyboard: SpiceVibeStoryBoards, ofType type: T.Type) -> T {
        let storyboardID = String(describing: type)
        guard let vc = storyboard.instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("ViewController with identifier \(storyboardID) not found in \(storyboard.rawValue) storyboard.")
        }
        return vc
    }
}
