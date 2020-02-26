//
//  GamePlayingState.swift
//  Stress
//
//  Created by Shawn Koh on 26/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class GamePlayingState: GKState, GameState {
    var stateMachine: GKStateMachine?

    func isValidNextState(_ stateClass: GKState.Type) -> Bool {
        stateClass is GameWinState.Type || stateClass is GameLoseState.Type || stateClass is GamePausedState.Type
    }

    func didEnter(from previousState: GKState?) {
        playingScene.stage.presentScene(playingScene.levelScene)
        playingScene.level.pegs.forEach { playingScene.levelScene.addEntity($0) }
    }

    func update(deltaTime seconds: TimeInterval) {}

    func willExit(to nextState: GKState) {}
}
