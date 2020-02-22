//
//  TitleScreenState.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class TitleScreenState: GKState, SceneState {
    weak var stateMachine: GKStateMachine?

    func isValidNextState(_ stateClass: GKState.Type) -> Bool {
        stateClass is SelectingLevelState.Type || stateClass is DesigningState.Type
    }

    func didEnter(from previousState: GKState?) {
        presenter.presentScene(sceneStateMachine.titleScreen)
    }

    func update(deltaTime: TimeInterval) {
        // not sure
    }

    func willExit(to: GKState) {
        // not sure, clean up perhaps?
    }
}
