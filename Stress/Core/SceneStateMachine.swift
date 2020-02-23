//
//  SceneStateMachine.swift
//  Stress
//
//  Created by Shawn Koh on 20/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class SceneStateMachine: GKStateMachine {
    unowned var stress: Stress
    unowned var presenter: GKView

    init(stress: Stress, presenter: GKView, states: [GKState]) {
        self.stress = stress
        self.presenter = presenter
        super.init(states: states)
    }
}
