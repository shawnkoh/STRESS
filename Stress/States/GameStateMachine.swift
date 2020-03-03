//
//  GameStateMachine.swift
//  Stress
//
//  Created by Shawn Koh on 20/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

class GameStateMachine: GKStateMachine {
    unowned let stress: Stress
    unowned let navigationController: UINavigationController

    init(stress: Stress, navigationController: UINavigationController, states: [GKState]) {
        self.stress = stress
        self.navigationController = navigationController
        super.init(states: states)
        states.forEach { $0.stateMachine = self }
    }
}
