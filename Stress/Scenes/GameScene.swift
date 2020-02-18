//
//  GameScene.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

/// A `GameScene` represents the main gameplay scene in Stress.
class GameScene: GKScene {
    var level: Level?
    let background: UIImageView
    let cannon: Cannon

    override init(size: CGSize) {
        let topLeft = CGPoint(x: 0, y: 0)
        let topRight = CGPoint(x: size.width, y: 0)
        let bottomLeft = CGPoint(x: 0, y: size.height)
        let bottomRight = CGPoint(x: size.width, y: size.height)
        background = UIImageView(frame: .zero)
        background.image = StressSettings.defaultBackgroundImage
        background.contentMode = .scaleAspectFill
        background.center = CGPoint(x: size.width / 2, y: size.height / 2)
        background.bounds.size = size
        background.isUserInteractionEnabled = true
        cannon = Cannon(center: CGPoint(x: topRight.x / 2, y: 80), size: StressSettings.defaultCannonSize)
        super.init(size: size)

        let topWall = Wall(from: topLeft, to: topRight)
        let leftWall = Wall(from: topLeft, to: bottomLeft)
        let rightWall = Wall(from: topRight, to: bottomRight)
        let exit = Exit(from: bottomLeft, to: bottomRight)

        addEntity(cannon)
        addEntity(topWall)
        addEntity(leftWall)
        addEntity(rightWall)
        addEntity(exit)

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(controlCannon(_:)))
        background.addGestureRecognizer(panGesture)
    }

    override func didMove(to view: GKView) {
        super.didMove(to: view)
        view.addSubview(background)
        entities.forEach { entity in
            if let visualComponent = entity.component(ofType: VisualComponent.self) {
                view.addSubview(visualComponent.view)
            }
        }
        _ = background.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        _ = background.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        _ = background.topAnchor.constraint(equalTo: view.topAnchor)
        _ = background.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    }

    @objc func controlCannon(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: background)

        if sender.state == .changed {
            cannon.rotate(to: location)
        }

        if sender.state == .ended {
            cannon.component(ofType: FiringComponent.self)?.fire()
        }
    }

    func loadLevel(_ level: Level) {
        self.level = level
        for peg in level.pegs {
            addEntity(peg)
        }
    }
}
