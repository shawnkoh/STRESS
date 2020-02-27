//
//  GameState.swift
//  Stress
//
//  Created by Shawn Koh on 26/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

protocol GameState where Self: GKState {
    var gameStateMachine: GameStateMachine { get }
    var playingScene: PlayingScene { get }
}

extension GameState {
    unowned var gameStateMachine: GameStateMachine {
        guard let gameStateMachine = stateMachine as? GameStateMachine else {
            fatalError("GameState must be bounded to a GameStateMachine")
        }
        return gameStateMachine
    }
    unowned var playingScene: PlayingScene {
        gameStateMachine.playingScene
    }
}
