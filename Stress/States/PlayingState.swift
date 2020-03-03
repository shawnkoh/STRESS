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
    weak var playingScene: PlayingScene?

    func isValidNextState(_ stateClass: GKState.Type) -> Bool {
        stateClass is TitleScreenState.Type ||
        stateClass is WinState.Type ||
        stateClass is LoseState.Type ||
        stateClass is PausedState.Type
    }

    func didEnter(from previousState: GKState?) {
        if let selectingLevelState = previousState as? SelectingLevelState {
            guard let levelData = selectingLevelState.selectedLevelData else {
                fatalError("No level data selected")
            }
            let viewController = PlayingViewController(stateMachine: gameStateMachine,
                                                       levelData: levelData)
            gameStateMachine.navigationController.pushViewController(viewController, animated: true)
        }
    }

    func update(deltaTime seconds: TimeInterval) {}

    func willExit(to nextState: GKState) {}
}
