//
//  GameLoseState.swift
//  Stress
//
//  Created by Shawn Koh on 26/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class GameLoseState: GKState, GameState {
    weak var stateMachine: GKStateMachine?

    func isValidNextState(_ stateClass: GKState.Type) -> Bool {
        stateClass is GamePlayingState.Type
    }

    func didEnter(from previousState: GKState?) {}

    func update(deltaTime seconds: TimeInterval) {}

    func willExit(to nextState: GKState) {}
}
