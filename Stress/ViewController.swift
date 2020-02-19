//
//  ViewController.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var stress: Stress = {
        guard let presenter = self.view as? GKView else {
            fatalError("No presenter")
        }
        return Stress(presenter: presenter)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        stress.sceneStateMachine.enter(PlayingState.self)
    }

    override var prefersStatusBarHidden: Bool {
        true
    }
}
