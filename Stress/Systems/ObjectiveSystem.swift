//
//  ObjectiveSystem.swift
//  Stress
//
//  Created by Shawn Koh on 26/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class ObjectiveSystem: GKSystem {
    init(scene: GKScene) {
        super.init(scene: scene, componentClasses: [ObjectiveComponent.self])
    }

    override func update(deltaTime: TimeInterval) {
        if entities.isEmpty {
            // end game
        }
    }
}
