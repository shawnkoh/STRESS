//
//  TitleScreenState.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class TitleScreenState: GKState {
    weak var stateMachine: GKStateMachine?

    func isValidNextState(_ stateClass: GKState.Type) -> Bool {
        stateClass is PlayingState.Type || stateClass is DesigningState.Type
    }

    func didEnter(from previousState: GKState?) {
        // present title screen
    }

    func update(deltaTime: TimeInterval) {
        // not sure
    }

    func willExit(to: GKState) {
        // not sure, clean up perhaps?
    }
}
