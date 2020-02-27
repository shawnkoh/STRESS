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
        let view = GamePausedView()
        gameStateMachine.playingScene.stage.addSubview(view)
        view.restartButton.addTarget(self, action: #selector(restartLevel(_:)), for: .touchUpInside)
        view.quitButton.addTarget(self, action: #selector(quitLevel(_:)), for: .touchUpInside)
    }

    func update(deltaTime seconds: TimeInterval) {
    }

    func willExit(to nextState: GKState) {
    }

    @objc func restartLevel(_ sender: Button) {
        playingScene.restartLevel()
        gameStateMachine.enter(GamePlayingState.self)
    }

    @objc func quitLevel(_ sender: Button) {
        playingScene.stress.sceneStateMachine.enter(TitleScreenState.self)
    }
}
