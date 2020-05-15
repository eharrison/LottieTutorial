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

    private var animationView: AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView = .init(name: "coffee")
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
}
