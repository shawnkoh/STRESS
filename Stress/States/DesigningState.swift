//
//  DesigningState.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class DesigningState: GKState, GameState {
    weak var stateMachine: GKStateMachine?

    func isValidNextState(_ stateClass: GKState.Type) -> Bool {
        stateClass is TitleScreenState.Type || stateClass is PlayingState.Type
    }

    func didEnter(from previousState: GKState?) {
        switch previousState {
        case let selectingState as SelectingLevelState:
            let designer = DesignerViewController(store: gameStateMachine.stress.store,
                                                  stateMachine: gameStateMachine,
                                                  levelData: selectingState.selectedLevelData ?? LevelData())
            gameStateMachine.navigationController.pushViewController(designer, animated: true)

        case _ as TitleScreenState:
            let designer = DesignerViewController(store: gameStateMachine.stress.store,
                                                  stateMachine: gameStateMachine,
                                                  levelData: LevelData())
            gameStateMachine.navigationController.pushViewController(designer, animated: true)

        default:
            fatalError("Unsupported previousState")
        }
    }

    func update(deltaTime seconds: TimeInterval) {}

    func willExit(to nextState: GKState) {
        gameStateMachine.navigationController.popViewController(animated: false)
    }
}
