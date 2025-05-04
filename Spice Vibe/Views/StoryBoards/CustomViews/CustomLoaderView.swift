//  CustomLoaderView.swift
//  Spice Vibe
//  Created by caglobal on 05/03/25.

import UIKit
import Lottie

class LoaderManager {
    
    static let shared = LoaderManager()
    private var animationView: LottieAnimationView?
    private var backgroundView: UIView?

    private init() {}

    func showLoader(on view: UIView) {
        // Create background overlay
        backgroundView = UIView(frame: view.bounds)
        backgroundView?.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        // Setup Lottie animation
        animationView = LottieAnimationView(name: "Animation - 1741156096898")
        animationView?.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
        animationView?.center = view.center
        animationView?.contentMode = .scaleAspectFit
        animationView?.loopMode = .loop
        animationView?.play()
        
        // Add to view
        if let backgroundView = backgroundView, let animationView = animationView {
            view.addSubview(backgroundView)
            view.addSubview(animationView)
        }
    }

    func showBurgerLoader(on view: UIView){
        // Create background overlay
        backgroundView = UIView(frame: view.bounds)
        backgroundView?.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        // Setup Lottie animation
        animationView = LottieAnimationView(name: "Animation - 1741267678534")
        animationView?.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
        animationView?.center = view.center
        animationView?.contentMode = .scaleAspectFit
        animationView?.loopMode = .loop
        animationView?.play()
        
        // Add to view
        if let backgroundView = backgroundView, let animationView = animationView {
            view.addSubview(backgroundView)
            view.addSubview(animationView)
        }
    }
    
    func showNooddlesLoader(on view: UIView){
        // Create background overlay
        backgroundView = UIView(frame: view.bounds)
        backgroundView?.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        // Setup Lottie animation
        animationView = LottieAnimationView(name: "Animation - 1741269868079")
        animationView?.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
        animationView?.center = view.center
        animationView?.contentMode = .scaleAspectFit
        animationView?.loopMode = .loop
        animationView?.play()
        
        // Add to view
        if let backgroundView = backgroundView, let animationView = animationView {
            view.addSubview(backgroundView)
            view.addSubview(animationView)
        }
    }
    
    func hideLoader() {
        animationView?.stop()
        animationView?.removeFromSuperview()
        backgroundView?.removeFromSuperview()
        animationView = nil
        backgroundView = nil
    }
}

