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
    unowned var level: Level
    lazy var stage: Stage = {
        let stage = Stage(size: level.size)
        stage.presentScene(levelScene)
        level.pegs.forEach { levelScene.addEntity($0) }
        return stage
    }()
    lazy var levelScene = LevelPlayingScene(level: level)
    let background = Background()
    let menuButton = UIImageView(image: UIImage(systemName: "pause.circle"))

    init(stress: Stress, level: Level) {
        self.stress = stress
        self.level = level
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
