//
//  LoseState.swift
//  Stress
//
//  Created by Shawn Koh on 26/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class LoseState: GKState, GameState {
    weak var stateMachine: GKStateMachine?
    weak var playingScene: PlayingScene?

    func isValidNextState(_ stateClass: GKState.Type) -> Bool {
        stateClass is PlayingState.Type
    }

    func didEnter(from previousState: GKState?) {
        print("lost")
    }

    func update(deltaTime seconds: TimeInterval) {}

    func willExit(to nextState: GKState) {}
}
