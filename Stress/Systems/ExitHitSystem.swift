//
//  ExitHitSystem.swift
//  Stress
//
//  Created by Shawn Koh on 29/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class ExitHitSystem: GKSystem {
    init(scene: GKScene) {
        super.init(scene: scene, componentClasses: [PegComponent.self, DidHitComponent.self])
    }

    override func update(deltaTime: TimeInterval) {
        let exits = scene.entities(ofType: Exit.self)
        guard exits.contains(where: { $0.component(ofType: DidHitComponent.self) != nil }) else {
            return
        }

        entities.forEach { $0.addComponent(WillDestroyComponent()) }
        exits.forEach { $0.removeComponent(ofType: DidHitComponent.self) }
    }
}
