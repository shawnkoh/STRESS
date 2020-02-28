//
//  WinState.swift
//  Stress
//
//  Created by Shawn Koh on 26/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation
import UIKit

class WinState: GKState, GameState {
    weak var stateMachine: GKStateMachine?
    weak var playingScene: PlayingScene?

    func isValidNextState(_ stateClass: GKState.Type) -> Bool {
        stateClass is PlayingState.Type
    }

    func didEnter(from previousState: GKState?) {
        guard let playingScene = playingScene else {
            fatalError("Unable to access PlayingScene")
        }

        playingScene.stage.displayLink?.invalidate()
        let replayAction = {
            self.playingScene?.restartLevel()
            self.gameStateMachine.enter(PlayingState.self)
        }
        let view = GameWinView(score: playingScene.levelScene.scoreSystem.score, replayAction: replayAction)
        playingScene.stage.addSubview(view)
    }

    func update(deltaTime seconds: TimeInterval) {}

    func willExit(to nextState: GKState) {}
}
