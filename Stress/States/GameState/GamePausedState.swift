//
//  GamePausedState.swift
//  Stress
//
//  Created by Shawn Koh on 26/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class GamePausedState: GKState, GameState {
    weak var stateMachine: GKStateMachine?

    func isValidNextState(_ stateClass: GKState.Type) -> Bool {
        stateClass is GamePlayingState.Type
    }

    func didEnter(from previousState: GKState?) {
        playingScene.stage.displayLink?.invalidate()

        let restartLevel = {
            self.playingScene.restartLevel()
            self.gameStateMachine.enter(GamePlayingState.self)
        }

        let quitLevel = {
            self.playingScene.stress.sceneStateMachine.enter(TitleScreenState.self)
            return
        }

        let view = GamePausedView(restartAction: restartLevel, quitAction: quitLevel)
        playingScene.stage.addSubview(view)
    }

    func update(deltaTime seconds: TimeInterval) {
    }

    func willExit(to nextState: GKState) {
    }
}
