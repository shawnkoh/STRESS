//
//  GameState.swift
//  Stress
//
//  Created by Shawn Koh on 27/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

protocol GameState where Self: GKState {
    var gameStateMachine: GameStateMachine { get }
}

extension GameState {
    var gameStateMachine: GameStateMachine {
        guard let stateMachine = stateMachine as? GameStateMachine else {
            fatalError("Unable to access state machine")
        }
        return stateMachine
    }
}
