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
    unowned let stress: Stress
    lazy var stage: Stage = {
        let stage = Stage(size: level.size)
        stage.presentScene(levelScene)
        levelScene.addSystem(CannonControlSystem(controller: stage))
        levelScene.addSystem(TransformSystem())

        let size = level.size
        let topLeft = CGPoint(x: 0, y: 0)
        let topRight = CGPoint(x: size.width, y: 0)
        let bottomLeft = CGPoint(x: 0, y: size.height)
        let bottomRight = CGPoint(x: size.width, y: size.height)
        let topWall = Wall(from: topLeft, to: topRight)
        let leftWall = Wall(from: topLeft, to: bottomLeft)
        let rightWall = Wall(from: topRight, to: bottomRight)
        let exit = Exit(from: bottomLeft, to: bottomRight)
        levelScene.addEntity(cannon)
        levelScene.addEntity(topWall)
        levelScene.addEntity(leftWall)
        levelScene.addEntity(rightWall)
        levelScene.addEntity(exit)
        level.pegs.forEach { levelScene.addEntity($0) }
        return stage
    }()
    lazy var levelScene: LevelScene = {
        let levelScene = LevelScene()
        level.delegate = levelScene
        return levelScene
    }()
    let background = Background()
    let menuButton = UIImageView(image: UIImage(systemName: "pause.circle"))
    lazy var cannon = Cannon(center: CGPoint(x: level.size.width / 2, y: 80),
                             size: StressSettings.defaultCannonSize)
    unowned var level: Level {
        guard let level = stress.sceneStateMachine.state(forClass: PlayingState.self)?.level else {
            fatalError("Unable to access level")
        }
        return level
    }

    init(stress: Stress) {
        self.stress = stress
        super.init()
        menuButton.bounds.size = CGSize(width: 48, height: 48)
        menuButton.isUserInteractionEnabled = true
        let menuGesture = UITapGestureRecognizer(target: self, action: #selector(tapMenu(_:)))
        menuButton.addGestureRecognizer(menuGesture)
        background.addSubview(menuButton)
    }

    override func didMove(to view: GKView) {
        super.didMove(to: view)
        let size = level.size
        view.addSubview(background)
        view.addSubview(stage)
        view.addSubview(menuButton)
        NSLayoutConstraint.activate([
            stage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        menuButton.center = CGPoint(x: size.width - 100, y: 80)
    }

    @objc func tapMenu(_ sender: UITapGestureRecognizer) {
        stress.sceneStateMachine.enter(TitleScreenState.self)
    }
}
