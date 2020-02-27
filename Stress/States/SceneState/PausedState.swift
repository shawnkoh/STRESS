//
//  PausedState.swift
//  Stress
//
//  Created by Shawn Koh on 26/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class PausedState: GKState, GameState {
    weak var stateMachine: GKStateMachine?
    weak var playingScene: PlayingScene?
    lazy var gamePausedView: GamePausedView = {
        let resumeLevel = {
            self.playingScene?.isPaused = false
            self.gameStateMachine.enter(PlayingState.self)
            return
        }

        let restartLevel = {
            self.playingScene?.restartLevel()
            self.gameStateMachine.enter(PlayingState.self)
        }

        let quitLevel = {
            self.gameStateMachine.enter(TitleScreenState.self)
            return
        }

        let gamePausedView = GamePausedView(resumeAction: resumeLevel,
                                            restartAction: restartLevel,
                                            quitAction: quitLevel)
        return gamePausedView
    }()

    func isValidNextState(_ stateClass: GKState.Type) -> Bool {
        stateClass is PlayingState.Type || stateClass is TitleScreenState.Type
    }

    func didEnter(from previousState: GKState?) {
        playingScene?.isPaused = true
        playingScene?.stage.addSubview(gamePausedView)
    }

    func update(deltaTime seconds: TimeInterval) {
    }

    func willExit(to nextState: GKState) {
        playingScene?.isPaused = false
        gamePausedView.removeFromSuperview()
    }
}
