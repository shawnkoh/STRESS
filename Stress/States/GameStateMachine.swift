//
//  GameStateMachine.swift
//  Stress
//
//  Created by Shawn Koh on 20/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class GameStateMachine: GKStateMachine {
    unowned let stress: Stress
    unowned var presenter: GKView

    init(stress: Stress, presenter: GKView, states: [GKState]) {
        self.stress = stress
        self.presenter = presenter
        super.init(states: states)
        states.forEach { $0.stateMachine = self }
    }
}
