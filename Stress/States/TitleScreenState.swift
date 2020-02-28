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
        let selectLevel = {
            self.gameStateMachine.enter(SelectingLevelState.self)
            return
        }
        let createLevel = {
            self.gameStateMachine.enter(DesigningState.self)
            return
        }
        let titleScreen = TitleScreen(playAction: selectLevel, designAction: createLevel)

        gameStateMachine.presenter.presentScene(titleScreen)
    }

    func update(deltaTime: TimeInterval) {
        // not sure
    }

    func willExit(to nextState: GKState) {
        if let designingState = nextState as? DesigningState {
            designingState.levelData = nil
        }
    }
}
