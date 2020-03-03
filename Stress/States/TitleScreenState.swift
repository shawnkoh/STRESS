//
//  TitleScreenState.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class TitleScreenState: GKState, GameState {
    weak var stateMachine: GKStateMachine?

    func isValidNextState(_ stateClass: GKState.Type) -> Bool {
        stateClass is SelectingLevelState.Type || stateClass is DesigningState.Type
    }

    func didEnter(from previousState: GKState?) {
        let titleScreen = TitleScreenController(stateMachine: gameStateMachine)
        if gameStateMachine.navigationController.viewControllers.isEmpty {
            gameStateMachine.navigationController.pushViewController(titleScreen, animated: false)
        } else {
            gameStateMachine.navigationController.popToRootViewController(animated: false)
        }
    }

    func update(deltaTime: TimeInterval) {
        // not sure
    }

    func willExit(to nextState: GKState) {}
}
