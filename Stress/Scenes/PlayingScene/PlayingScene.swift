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
    unowned let stateMachine: GameStateMachine
    unowned var levelData: LevelData
    lazy var level = Store.constructLevel(from: levelData)
    lazy var stage = Stage(size: level.size)
    lazy var levelScene = LevelPlayingScene(parent: self, level: level)
    let background = Background()
    let ammoLabel = AmmoLabel()
    let scoreLabel = ScoreLabel()

    init(stateMachine: GameStateMachine, levelData: LevelData) {
        self.stateMachine = stateMachine
        self.levelData = levelData
        super.init()
    }

    override func didMove(to view: GKView) {
        super.didMove(to: view)
        let menuButton = MenuButton(action: { self.stateMachine.enter(PausedState.self) })
        view.addSubview(background)
        view.addSubview(ammoLabel)
        view.addSubview(scoreLabel)
        view.addSubview(menuButton)
        view.addSubview(stage)

        NSLayoutConstraint.activate([
            ammoLabel.leadingAnchor.constraint(equalTo: stage.leadingAnchor),
            ammoLabel.bottomAnchor.constraint(equalTo: stage.topAnchor),
            scoreLabel.centerXAnchor.constraint(equalTo: stage.centerXAnchor),
            scoreLabel.bottomAnchor.constraint(equalTo: stage.topAnchor),
            menuButton.trailingAnchor.constraint(equalTo: stage.trailingAnchor),
            menuButton.bottomAnchor.constraint(equalTo: stage.topAnchor),
            stage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func restartLevel() {
        level = Store.constructLevel(from: levelData)
        levelScene = LevelPlayingScene(parent: self, level: level)
        level.pegs.forEach { levelScene.addEntity($0) }
        stage.presentScene(levelScene)
    }
}
