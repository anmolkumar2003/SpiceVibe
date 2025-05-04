//  MainTabBarViewController.swift
//  Spice Vibe
//  Created by caglobal on 03/03/25.

import UIKit
import RAMAnimatedTabBarController

class MainTabBarController: RAMAnimatedTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarAnimations()
    }
    
    private func setupTabBarAnimations() {
        if let items = tabBar.items as? [RAMAnimatedTabBarItem] {
            // Set images for tab bar items
            items[0].image = UIImage(systemName: "house.fill")
            items[0].animation = RAMBounceAnimation()
            
            items[1].image = UIImage(systemName: "heart.fill")
            items[1].animation = RAMFumeAnimation()
            
            items[2].image = UIImage(systemName: "cart.fill")
            items[2].animation = RAMFlipTopTransitionItemAnimations()
            
            items[2].image = UIImage(systemName: "cart.fill")
            items[2].animation = RAMFlipTopTransitionItemAnimations()
        }
    }
}
