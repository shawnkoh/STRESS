//
//  PlayingScene.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

/// A `PlayingScene` represents the main gameplay scene in Stress.
class PlayingScene: GKScene {
    var level: Level?
    let background = Background()
    let menuButton = UIImageView(image: UIImage(systemName: "pause.circle"))
    let cannon: Cannon
    unowned let stress: Stress

    /// Convenience variable
    init(stress: Stress, size: CGSize) {
        self.stress = stress

        let topLeft = CGPoint(x: 0, y: 0)
        let topRight = CGPoint(x: size.width, y: 0)
        let bottomLeft = CGPoint(x: 0, y: size.height)
        let bottomRight = CGPoint(x: size.width, y: size.height)

        menuButton.bounds.size = CGSize(width: 48, height: 48)
        menuButton.center = CGPoint(x: topRight.x - 100, y: 80)
        menuButton.isUserInteractionEnabled = true
        background.addSubview(menuButton)
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

        let menuGesture = UITapGestureRecognizer(target: self, action: #selector(tapMenu(_:)))
        menuButton.addGestureRecognizer(menuGesture)
    }

    override func didMove(to view: GKView) {
        super.didMove(to: view)
        view.addSubview(background)
        entities.compactMap { $0.component(ofType: VisualComponent.self)?.view }
                .forEach { view.addSubview($0) }
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

    @objc func tapMenu(_ sender: UITapGestureRecognizer) {
        stress.sceneStateMachine.enter(TitleScreenState.self)
    }

    func loadLevel(_ level: Level) {
        self.level = level
        level.pegs.forEach { addEntity($0) }
    }
}