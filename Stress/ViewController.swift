//
//  ViewController.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var gameScene: GameScene!

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let view = view as? GKView else {
            fatalError("ViewController's view is not a GKView")
        }
        let size = view.frame.size
        // Stub level
        let level = Level(name: "Stub", size: size)
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

        gameScene = GameScene(size: size)
        gameScene.loadLevel(level)

        view.presentScene(gameScene)
    }

    override var prefersStatusBarHidden: Bool {
        true
    }
}
