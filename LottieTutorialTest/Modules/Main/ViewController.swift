//
//  ViewController.swift
//  LottieTutorialTest
//
//  Created by Evandro Harrison Hoffmann on 13/05/2020.
//  Copyright © 2020 LottieFiles. All rights reserved.
//

import UIKit
import Lottie

class ViewController: UIViewController {

    private var animationView: LottieAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView = .init(name: "cat")
        animationView!.frame = view.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 0.5
        view.addSubview(animationView!)
        animationView!.play()
        
        view.sendSubviewToBack(animationView!)
        
    }
    
    @IBAction func openDownload(_ sender: Any) {
        let viewController = DownloadViewController(nibName: "DownloadViewController", bundle: nil)
        present(viewController, animated: true)
    }
    
    @IBAction func changeColor(_ sender: Any) {
        // log list of keypaths
        // Search for ".Color"
        // Use ** to replace all matches of a node
        animationView?.logHierarchyKeypaths()
        
        // changing face colors with random UIColor
        animationView?.setValueProvider(ColorValueProvider(UIColor.random().lottieColorValue),
                                        keypath: AnimationKeypath(keypath: "face.**.Fill 1.Color"))
        
        // Handling color based on theme
        let isDarkUI = traitCollection.userInterfaceStyle == .dark
        let color: UIColor = isDarkUI ? .yellow : .gray
        
        animationView?.setValueProvider(ColorValueProvider(color.lottieColorValue),
                                        keypath: AnimationKeypath(keypath: "body 2.**.Fill 1.Color"))
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}
