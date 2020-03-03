//
//  PlayingState.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class PlayingState: GKState, GameState {
    weak var stateMachine: GKStateMachine?
    var levelData: LevelData?
    weak var playingScene: PlayingScene?

    func isValidNextState(_ stateClass: GKState.Type) -> Bool {
        stateClass is TitleScreenState.Type ||
        stateClass is WinState.Type ||
        stateClass is LoseState.Type ||
        stateClass is PausedState.Type
    }

    func didEnter(from previousState: GKState?) {
        guard let levelData = levelData else {
            fatalError("Could not access required dependencies.")
        }
        if previousState is SelectingLevelState {
            let viewController = PlayingViewController(stateMachine: gameStateMachine, levelData: levelData)
            gameStateMachine.navigationController.pushViewController(viewController, animated: true)
        }
    }

    func update(deltaTime seconds: TimeInterval) {}

    func willExit(to nextState: GKState) {}
}
