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
    unowned var levelData: LevelData
    lazy var level = Store.constructLevel(from: levelData)
    lazy var stage = Stage(size: level.size)
    lazy var levelScene = LevelPlayingScene(parent: self, level: level)
    let background = Background()
    let menuButton = UIImageView(image: UIImage(systemName: "pause.circle"))
    lazy var stateMachine = GameStateMachine(playingScene: self,
                                             states: [GamePlayingState(),
                                                      GameWinState(),
                                                      GameLoseState(),
                                                      GamePausedState()])

    init(stress: Stress, levelData: LevelData) {
        self.stress = stress
        self.levelData = levelData
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
        stateMachine.enter(GamePlayingState.self)
    }

    @objc func tapMenu(_ sender: UITapGestureRecognizer) {
        stateMachine.enter(GamePausedState.self)
    }

    func restartLevel() {
        level = Store.constructLevel(from: levelData)
        levelScene = LevelPlayingScene(parent: self, level: level)
        level.pegs.forEach { levelScene.addEntity($0) }
        stage.presentScene(levelScene)
    }
}
