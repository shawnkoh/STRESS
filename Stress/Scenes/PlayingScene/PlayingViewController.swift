//
//  PlayingViewController.swift
//  Stress
//
//  Created by Shawn Koh on 2/3/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class PlayingViewController: UIViewController {
    unowned let stateMachine: GameStateMachine
    unowned let levelData: LevelData

    init(stateMachine: GameStateMachine, levelData: LevelData) {
        self.stateMachine = stateMachine
        self.levelData = levelData
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = GKView()
    }

    override func viewDidLoad() {
        guard let view = view as? GKView else {
            fatalError("GKView failed to instantiate")
        }
        super.viewDidLoad()
        let playingScene = PlayingScene(stateMachine: stateMachine, levelData: levelData)
        view.presentScene(playingScene)
        playingScene.stage.presentScene(playingScene.levelScene)
        playingScene.level.pegs.forEach { playingScene.levelScene.addEntity($0) }
        playingScene.ammoLabel.text = "Shots left: \(Settings.Cannon.ammo)"
        stateMachine.state(forClass: WinState.self)?.playingScene = playingScene
        stateMachine.state(forClass: LoseState.self)?.playingScene = playingScene
        stateMachine.state(forClass: PausedState.self)?.playingScene = playingScene
    }
}
