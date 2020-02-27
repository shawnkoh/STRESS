//
//  PlayingState.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class PlayingState: GKState, GameState {
    weak var stateMachine: GKStateMachine?
    var levelData: LevelData?
    weak var playingScene: PlayingScene?

    func isValidNextState(_ stateClass: GKState.Type) -> Bool {
        stateClass is TitleScreenState.Type ||
        stateClass is WinState.Type ||
        stateClass is LoseState.Type ||
        stateClass is PausedState.Type
    }

    func didEnter(from previousState: GKState?) {
        guard let levelData = levelData else {
            fatalError("Could not access required dependencies.")
        }
        if previousState is SelectingLevelState {
            let playingScene = PlayingScene(stateMachine: gameStateMachine, levelData: levelData)
            gameStateMachine.presenter.presentScene(playingScene)
            playingScene.stage.presentScene(playingScene.levelScene)
            playingScene.level.pegs.forEach { playingScene.levelScene.addEntity($0) }
            self.playingScene = playingScene
        }
    }

    func update(deltaTime seconds: TimeInterval) {}

    func willExit(to nextState: GKState) {
        if let winState = nextState as? WinState {
            winState.playingScene = playingScene
        } else if let loseState = nextState as? LoseState {
            loseState.playingScene = playingScene
        } else if let pausedState = nextState as? PausedState {
            pausedState.playingScene = playingScene
        }
    }
}
