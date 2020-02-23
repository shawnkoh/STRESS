//
//  DesigningState.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class DesigningState: GKState, SceneState {
    weak var stateMachine: GKStateMachine?
    var level: Level?

    func isValidNextState(_ stateClass: GKState.Type) -> Bool {
        stateClass is TitleScreenState.Type || stateClass is PlayingState.Type
    }

    func didEnter(from previousState: GKState?) {
        if level == nil {
            level = Level(name: StressSettings.defaultLevelName,
                          size: StressSettings.defaultLevelSize)
        }
        presenter.presentScene(sceneStateMachine.levelDesignerScene)
    }

    func update(deltaTime seconds: TimeInterval) {}

    func willExit(to nextState: GKState) {}
}
