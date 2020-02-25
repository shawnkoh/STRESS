//
//  DestroySystem.swift
//  Stress
//
//  Created by Shawn Koh on 26/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class DestroySystem: GKSystem {
    init(scene: GKScene) {
        super.init(scene: scene, componentClasses: [WillDestroyComponent.self])
    }

    override func update(deltaTime: TimeInterval) {
        scene.entities.filter { $0.component(ofType: WillDestroyComponent.self) != nil }
                      .forEach { scene.removeEntity($0) }
    }
}
