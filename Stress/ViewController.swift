//
//  ViewController.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class ViewController: UINavigationController {
    lazy var stress = Stress(navigationController: self)

    override func viewDidAppear(_ animated: Bool) {
        isNavigationBarHidden = true
        super.viewDidAppear(animated)
        stress.stateMachine.enter(TitleScreenState.self)
    }

    override var prefersStatusBarHidden: Bool {
        true
    }

    @objc func click() {

    }
}
