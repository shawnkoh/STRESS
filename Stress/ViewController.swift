//
//  ViewController.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var stress = Stress(size: view.frame.size)
    lazy var gameScene = GameScene(size: view.frame.size)
    lazy var levelDesignerScene = LevelDesignerScene(size: view.frame.size)

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let view = view as? GKView else {
            fatalError("ViewController's view is not a GKView")
        }
        // Stub level
        let level = Level(name: "Stub", size: view.frame.size)
        level.addPeg(Peg(center: CGPoint(x: 60, y: 300), type: .normal))
        level.addPeg(Peg(center: CGPoint(x: 120, y: 350), type: .objective))
        level.addPeg(Peg(center: CGPoint(x: 180, y: 400), type: .objective))
        level.addPeg(Peg(center: CGPoint(x: 240, y: 400), type: .objective))
        level.addPeg(Peg(center: CGPoint(x: 300, y: 350), type: .objective))
        level.addPeg(Peg(center: CGPoint(x: 360, y: 300), type: .objective))
        level.addPeg(Peg(center: CGPoint(x: 60, y: 500), type: .normal))
        level.addPeg(Peg(center: CGPoint(x: 120, y: 550), type: .objective))
        level.addPeg(Peg(center: CGPoint(x: 180, y: 600), type: .objective))
        level.addPeg(Peg(center: CGPoint(x: 240, y: 600), type: .objective))
        level.addPeg(Peg(center: CGPoint(x: 300, y: 550), type: .objective))
        level.addPeg(Peg(center: CGPoint(x: 360, y: 500), type: .objective))
        gameScene.loadLevel(level)

        view.presentScene(gameScene)
    }

    override var prefersStatusBarHidden: Bool {
        true
    }
}
