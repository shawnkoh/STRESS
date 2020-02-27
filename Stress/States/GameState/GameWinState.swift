//
//  GameWinState.swift
//  Stress
//
//  Created by Shawn Koh on 26/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation
import UIKit

class GameWinState: GKState, GameState {
    weak var stateMachine: GKStateMachine?

    func isValidNextState(_ stateClass: GKState.Type) -> Bool {
        stateClass is GamePlayingState.Type
    }

    func didEnter(from previousState: GKState?) {
        playingScene.stage.displayLink?.invalidate()
        let replayAction = {
            self.playingScene.restartLevel()
            self.gameStateMachine.enter(GamePlayingState.self)
        }
        let view = GameWinView(score: playingScene.levelScene.scoreSystem.score, replayAction: replayAction)
        playingScene.stage.addSubview(view)
    }

    func update(deltaTime seconds: TimeInterval) {}

    func willExit(to nextState: GKState) {}
}
